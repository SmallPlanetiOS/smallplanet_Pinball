from __future__ import division

from keras.callbacks import LearningRateScheduler, ModelCheckpoint, Callback
from keras.preprocessing.image import ImageDataGenerator
from keras.optimizers import SGD
from keras import backend as K
from clr_callback import CyclicLR
import model
import images
import numpy as np
import os
import gc
import comm

import coremltools   
import h5py




# used for realistic accuracy reporting during training...
class EvaluationMonitor(Callback):  
    imgs = []
    labels = []
    
    def round2(self, x, y):
        if x > y:
            return 1.0
        return 0.0

    def calc_predict(self, predictions, value):
        numCorrect = 0
        for i in range(0,len(self.labels)):
            numCorrect += (self.round2(predictions[i][0], value) == round(self.labels[i][0]) and 
                            self.round2(predictions[i][1], value) == round(self.labels[i][1]) and 
                            self.round2(predictions[i][2], value) == round(self.labels[i][2]) and
                            self.round2(predictions[i][3], value) == round(self.labels[i][3]))
        acc = numCorrect / len(self.labels)
        print("\n ({}) prediction accuracy = {} out of {}".format(value, acc, len(self.labels)))
    
    def on_epoch_end(self, epoch, logs={}): 
        predictions = model.predict(self.imgs)
        self.calc_predict(predictions, 0.000001)
        self.calc_predict(predictions, 0.05)
        self.calc_predict(predictions, 0.1)
        self.calc_predict(predictions, 0.2)
        self.calc_predict(predictions, 0.3)
        self.calc_predict(predictions, 0.4)
        self.calc_predict(predictions, 0.5)
        self.calc_predict(predictions, 0.6)
        self.calc_predict(predictions, 0.7)
        self.calc_predict(predictions, 0.8)









batch_size = 16
epochs = 6

permanent_path = "./pmemory/"
permanent_max_size = 0

train_path = "./memory/"
train_max_size = 0

# create the model
print("Generating the CNN model...")
model = model.cnn_model()

model.compile(loss='binary_crossentropy',
              optimizer='rmsprop',
              metrics=['accuracy'])

# if we have some pre-existing weights, load those first
if os.path.isfile("model.h5"):
    print("Loading previous model weights...")
    model.load_weights("model.h5")

print("Allocating the image data generator...")
datagen = ImageDataGenerator(featurewise_center=False,
                             featurewise_std_normalization=False,
                             width_shift_range=0.02,
                             height_shift_range=0.02,
                             )

coreMLPublisher = comm.publisher(comm.endpoint_pub_CoreMLUpdates)

def read_file(path):
    with open(path, 'rb') as f:
        return f.read()

def Learn():

    print("Load random selection of long term memories...")
    train_imgs = images.generate_image_array(train_path, train_max_size)
    train_labels = []
    
    images.load_images(train_imgs, train_labels, train_path, train_max_size)
    
    print("Load random selection of permanent memories...")
    permanent_imgs = images.generate_image_array(permanent_path, permanent_max_size)
    permanent_labels = []
    
    images.load_images(permanent_imgs, permanent_labels, permanent_path, permanent_max_size)
    
    
    if len(train_imgs) >= batch_size or len(permanent_imgs) >= batch_size:
        
        if os.path.isfile("model.h5"):
            print("Loading previous model weights...")
            model.load_weights("model.h5")
        
        # cyclic learning rate
        clr = CyclicLR(base_lr=0.001, max_lr=0.006,
                                step_size=(len(permanent_imgs) // batch_size * 4), mode='exp_range',
                                gamma=0.99994)
                                
        em = EvaluationMonitor()
        em.imgs = permanent_imgs
        em.labels = permanent_labels

        # free up whatever memory we can before training
        gc.collect()

        # first let's train the network on high accuracy on our unaltered images
        if len(permanent_imgs) >= batch_size:
            print("Training the permanent memories...")
            model.fit_generator(datagen.flow(permanent_imgs, permanent_labels, batch_size=batch_size),
                    steps_per_epoch=len(permanent_imgs) // batch_size,
                    epochs=epochs,
                    callbacks=[clr,em])
        
        # cyclic learning rate
        clr = CyclicLR(base_lr=0.001, max_lr=0.006,
                                step_size=(len(train_imgs) // batch_size * 4), mode='exp_range',
                                gamma=0.99994)
        
        em.imgs = train_imgs
        em.labels = train_labels

        # then let's train the network on the altered images
        if len(train_imgs) >= batch_size:
            print("Training the long term memories...")
            model.fit_generator(datagen.flow(train_imgs, train_labels, batch_size=batch_size),
                    steps_per_epoch=len(train_imgs) // batch_size,
                    epochs=epochs,
                    callbacks=[clr,em])
        
        model.save("model.h5")
        
        print("Training finished...")
        
        output_labels = ['left','right','start','ballkicker'] 
        coreml_model = coremltools.converters.keras.convert('model.h5',input_names='image',image_input_names = 'image',class_labels = output_labels)   
        coreml_model.author = 'Rocco Bowling'   
        coreml_model.short_description = 'RL Pinball model'
        coreml_model.input_description['image'] = 'Image of the play area of the pinball machine'
        coreml_model.save('pinballModel.mlmodel')

        print("Conversion to coreml finished...")
        
        
        modelBytes = read_file("pinballModel.mlmodel")        
        coreMLPublisher.send(modelBytes)
        
        print("Published new coreml model")
        
        






