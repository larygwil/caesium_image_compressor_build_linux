[Caesium Image Compressor](https://github.com/Lymphatus/caesium-image-compressor) Linux built binaries

Built and pushed by ~~Github Action (`ci` branch), and by~~ human.

To build [Caesium Image Compressor](https://github.com/Lymphatus/caesium-image-compressor) for Linux, you need (at least):

- Qt >= 6.2 (libQt6Core6, qt6-base-devel, qt6-core-devel)
    - Qtsvg (qt6-svg-devel)
    - Qt 6  tools , linguist tool(qt6-linguist-devel, qt6-tools-linguist)
    - (jurplel/install-qt-action:  modules: 'qtimageformats'  ,  archives: " qtbase  qtsvg icu  qttools "  )
- Vulkan
- xkb 
- gcc >= 9
- cargo 
