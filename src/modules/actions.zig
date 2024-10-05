const App = @import("../app.zig").App;
const Panel = @import("../ui/panel.zig").Panel;
const Motion = @import("./motion.zig").Motion;
const GridPosition = @import("../types/grid-position.zig").GridPosition;

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
        Motion.left => {
            if (app.state.activePanel == Panel.calendar) {
                moveCalenderCursorLeft(app);
            }
        },
        Motion.right => {
            if (app.state.activePanel == Panel.calendar) {
                moveCalenderCursorRight(app);
            }
        },
        Motion.up => {
            if (app.state.activePanel == Panel.calendar) {
                moveCalenderCursorUp(app);
            }
        },
        Motion.down => {
            if (app.state.activePanel == Panel.calendar) {
                moveCalenderCursorDown(app);
            }
        },
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

const calenderCols = 7;
const calendarRows = 5;

pub fn setCalenderCursorPosition(position: GridPosition, app: *App) void {
    if (position.x >= 0 and position.x < calenderCols and position.y >= 0 and position.y < calendarRows) {
        app.state.calendarCursorPosition = .{ .x = position.x, .y = position.y };
    }
}

pub fn moveCalenderCursorUp(app: *App) void {
    if (app.state.calendarCursorPosition.y == 0) {
        return;
    }
    setCalenderCursorPosition(.{
        .x = app.state.calendarCursorPosition.x,
        .y = app.state.calendarCursorPosition.y - 1,
    }, app);
}

pub fn moveCalenderCursorDown(app: *App) void {
    if (app.state.calendarCursorPosition.y == calendarRows - 1) {
        return;
    }
    setCalenderCursorPosition(.{
        .x = app.state.calendarCursorPosition.x,
        .y = app.state.calendarCursorPosition.y + 1,
    }, app);
}

pub fn moveCalenderCursorLeft(app: *App) void {
    if (app.state.calendarCursorPosition.x == 0) {
        return;
    }
    setCalenderCursorPosition(.{
        .x = app.state.calendarCursorPosition.x - 1,
        .y = app.state.calendarCursorPosition.y,
    }, app);
}

pub fn moveCalenderCursorRight(app: *App) void {
    if (app.state.calendarCursorPosition.x == calenderCols - 1) {
        return;
    }
    setCalenderCursorPosition(.{
        .x = app.state.calendarCursorPosition.x + 1,
        .y = app.state.calendarCursorPosition.y,
    }, app);
}
