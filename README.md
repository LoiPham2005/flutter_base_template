# cách dùng responsive

// WIDTH - Responsive theo chiều rộng
100.w     // 100 logical pixels (scale theo width)
0.5.sw    // 50% screen width
1.sw      // 100% screen width

// HEIGHT - Responsive theo chiều cao
50.h      // 50 logical pixels (scale theo height)
0.3.sh    // 30% screen height
1.sh      // 100% screen height

// RADIUS - Scale theo min(width, height)
12.r      // Border radius responsive

// FONT SIZE - Scale theo width
14.sp     // Font size responsive

// DIAGONAL - Scale theo đường chéo màn hình
100.sp    // Ít dùng, chủ yếu cho font size

// STATUS BAR & BOTTOM BAR
ScreenUtil().statusBarHeight  // Chiều cao status bar
ScreenUtil().bottomBarHeight  // Chiều cao bottom navigation

// ORIENTATION
ScreenUtil().orientation      // Portrait hay Landscape
