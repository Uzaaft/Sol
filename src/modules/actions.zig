const App = @import("../app.zig").App;
const Panel = @import("../ui/panel.zig").Panel;
const Motion = @import("./motion.zig").Motion;

pub fn quitApp(app: *App) void {
    app.should_quit = true;
}
pub fn setActivePanel(panel: Panel, app: *App) void {
    if (app.state.activePanel != panel) {
        app.state.activePanel = panel;
    }
}
pub fn handleMotion(motion: Motion, app: *App) void {
    switch (motion) {
        Motion.left => {},
        Motion.right => {},
        Motion.up => {},
        Motion.down => {},
        Motion.contextLeft => {
            // FIXME: not like this. need a motion manager
            // which checks the current context and takes appropriate action
            // for that context
            setActivePanel(Panel.events, app);
        },
        Motion.contextRight => {
            setActivePanel(Panel.calendar, app);
        },
        Motion.contextUp => {},
        Motion.contextDown => {},
    }
}
