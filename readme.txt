Visual Pulse Monitoring: Measuring Heart Rate of Faces in Ambient Lighting

I had this idea last year while building an atmega pulse monitor with infrared
LEDs and photoresistors. I was taking an information theory course and thought
it was a perfect opportunity to try out some real world signal processing. I
found that research into "photoplethysmography" is well-established if not
industry-ready.

N.B. This was a course project; this implementation is not robust, and not
particularly suited for any purpose.

The most closely related work is:
"Non-contact, automated cardiac pulse measurements using video imaging and blind
source separation" Ming-Zher Poh, Daniel J. McDuff, Rosalind W. Picard.
OSA (2010).

This project will begin by replicating their method and then (I hope) extend or
simplify it.

Input:
1.video of a person's forehead
2.video of a person's face without movement
3.video a moving face
4.video of several faces / a face in different illumination conditions
5.realtime video from a webcam

Pipeline:
0.capture webcam video in 24-bit color at 640x480 resolution and 15 fps;
  one minute duration; indoor illumination and sunlight illumination
1.detect faces or segment skin
  * detect faces w/ OpenCV implementation of viola-jones on
    captured video frames
  * take top 60% and middle 60% of each detected face as region of interest
2.process the RGB color channels as three sources (+ infrared, perhaps) and
  extract independent components
  * process RGB channels over 30 s moving window w/ 96.7% overlap (by increments
    of 1 s)
  * normalize channels to have zero mean and unit variance
  * whiten channels through eigendecomposition or singular-value decomposition.
    decorrelating channels and scaling to unit covariance simplifies the
    optimization by restricting the necessary transformations to rotations
  * find independent components through RADICAL by minimizing the total
    estimated entropy of the channels
3.Fast-Fourier Transform independent components to identify frequency powers
4.Take the most powerful peak in the operational range of healthy human
  pulses: 45-240 BPM or [.75, 4] Hz

Output:
1.Calculuated rate over a time window
2.Mark each pulse detected?
3.Face/skin detection visualizations?

Validation:
1.Off-the-shelf pulse oximeter with heart rate monitoring
2.Good old-fashioned counting
