const vaxis = @import("vaxis");
const App = @import("../app.zig").App;
const Panel = @import("../ui/panel.zig").Panel;
const Actions = @import("./actions.zig");
const Motion = @import("./motion.zig").Motion;

pub fn map(key: vaxis.Key, app: *App) void {
    // Quit signals
    if (key.matches('c', .{ .ctrl = true }))
        Actions.quitApp(app);
    if (key.matches('q', .{}))
        Actions.quitApp(app);

    // Motions
    if (key.matches('j', .{ .ctrl = false }))
        Actions.handleMotion(Motion.down, app);
    if (key.matches('k', .{ .ctrl = false }))
        Actions.handleMotion(Motion.up, app);
    if (key.matches('h', .{ .ctrl = false }))
        Actions.handleMotion(Motion.left, app);
    if (key.matches('l', .{ .ctrl = false }))
        Actions.handleMotion(Motion.right, app);

    // Context motions
    if (key.matches('j', .{ .ctrl = true }))
        Actions.handleMotion(Motion.contextDown, app);
    if (key.matches('k', .{ .ctrl = true }))
        Actions.handleMotion(Motion.contextUp, app);
    if (key.matches('h', .{ .ctrl = true }))
        Actions.handleMotion(Motion.contextLeft, app);
    if (key.matches('l', .{ .ctrl = true }))
        Actions.handleMotion(Motion.contextRight, app);
}
