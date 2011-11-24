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
1.video of a person's face without movement
2.video a moving face
3.video of several faces / a face in different illumination conditions
4.realtime video from a webcam

Pipeline:
0.train model of plausible pulse sequences/rates (need data on this) or
  take frequency with highest power in an operation range
1.detect faces or segment skin
2.process each color channel separately (+ infrared, perhaps) and extract
  independent components
3.Fast-Fourier Transform to identify periodic components
4.Map frequencies to plausible pulses or reject (need to account for sampling
  rate, noise)

Output:
1.Mark each pulse detected
2.Rate over a time window
3.Face/skin detection visualizations

Validation:
need to acquire some sort of cheap pulse monitor (usual cuff and counting?)
