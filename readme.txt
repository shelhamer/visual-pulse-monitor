Visual Pulse Monitoring: Measuring Heart Rate of Faces in Ambient Lighting

I had this idea last year while building an atmega pulse monitor with infrared
LEDs and photoresistors. I was taking an information theory course and thought
it was a perfect opportunity to try out some real world signal processing. I
found that research into "photoplethysmography" is well-established if not
industry-ready.

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
0.train model of plausible pulse sequences/rates (need data on this) or
  take frequency with highest power in an operation range
1.detect faces or segment skin
2.process the RGB color channels as three sources (+ infrared, perhaps) and
  extract independent components
3.Fast-Fourier Transform to identify frequency powers
4.Take the most powerful peak in the operational range of healthy human
  pulses: 40-240 BPM or [.75, 4] Hz

Output:
1.Calculuated rate over a time window
2.Mark each pulse detected?
3.Face/skin detection visualizations?

Validation:
1.Off-the-shelf pulse oximeter with heart rate monitoring
2.Good old-fashioned counting
