### GLGravity ###

===========================================================================
DESCRIPTION:

The GLGravity sample application demonstrates how to use the UIAccelerometer class in combination with OpenGL rendering. It shows how to extract the gravity vector from the accelerometer values using a basic low-pass filter, and how to build an OpenGL transformation matrix from it. Note that the result is not fully defined, as rotation of the device around the gravity vector cannot be detected by the accelerometer.

This application is designed to run on a device, not in the iPhone Simulator. To run this sample, choose Project > Set Active SDK > Device and connect a device. Then click Build and Go. Rotate the device and observe how the teapot always stays upright, independent of the device orientation.

===========================================================================
BUILD REQUIREMENTS:

Mac OS X 10.5.3, Xcode 3.1, iPhone OS 2.0

===========================================================================
RUNTIME REQUIREMENTS:

Mac OS X 10.5.3, iPhone OS 2.0

===========================================================================
PACKAGING LIST:

Classes/AppController.h
Classes/AppController.m
UIApplication's delegate class and the central controller of the application. Creates a fullscreen UIWindow and GLGravityView to host OpenGL ES content. Responds to the acceletometer to draw OpenGL content.

Classes/GLGravityView.h
Classes/GLGravityView.m
A UIView subclass that allows for the rendering of OpenGL ES content by a delegate that implements the GLGravityViewDelegate protocol.

Models/teapot.h
Contains data necessary for rendering the teapot model.

main.m
Entry point for this application. Creates the application object, sets its delegate, and starts the event loop.

===========================================================================
CHANGES FROM PREVIOUS VERSIONS:

Version 2.0
- First Public Release.

Version 1.4
- Updated for Beta 5

Version 1.3
- Updated for Beta 4
- Updated build settings
- Updated ReadMe file and converted it to plain text format for viewing on website

Version 1.2
- Updated for Beta 3
- Added an icon and a Default.png file

Version 1.1
- Updated for Beta 2	

===========================================================================
Copyright (C) 2008 Apple Inc. All rights reserved.