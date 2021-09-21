# MLProgramMemoryLeak
Every layer running on the GPU in ML Program will leak 912 bytes by MPSGraphEngine. This can easily lead to 200KB+ memory leak every time you run a larger model.

## Requirements
- Xcode 13.0+
- iOS 15.0+

## Usage
1. Build and install the app.
2. Launch the app in `Instruments -> Leaks`.
3. Every time you tap `Leak 100KB` there should be at least 100 more 912 bytes memory leaks at the next checkpoint of leaks.

## Workaround
If you are using a limited number of static models, cache `MLModel` objects. Otherwise don't use ML Program.
