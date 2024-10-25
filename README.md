# Animated Grid Demo

<video width="100%" controls>
  <source src="demo.mp4" type="video/mp4">
  Your browser does not support the video tag.
</video>

A Flutter project demonstrating a state-driven approach to creating beautiful loading animations for large datasets.

## Project Overview

This repository showcases an alternative approach to creating loading animations in Flutter applications, particularly when dealing with large datasets.

### Why This Project?

When loading large amounts of data, it's common to want to add a visually appealing animation where items appear one after another. Many existing solutions use AnimationController to manage these animations.

However, Flutter's UI is inherently state-driven. Using a "play animation" approach can feel disconnected from this paradigm. This demo presents a solution that aligns more closely with Flutter's state-driven nature.

### Key Features

- **Pure State-Driven Animations**: This demo uses a state-driven approach to control the delayed animations of child widgets.
- **One-Time Animation**: The loading animation triggers only on the initial load, avoiding unnecessary repetition on subsequent state changes.
