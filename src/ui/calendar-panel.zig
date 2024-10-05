const vaxis = @import("vaxis");
const colors = @import("../styles/colors.zig");
const Calendar = @import("calendar.zig");
const GridPosition = @import("../types/grid-position.zig").GridPosition;

pub const CalendarPanelDrawOpts = struct {
    isActivePanel: bool = false,
    calendarCursorPosition: GridPosition = .{ .x = 0, .y = 0 },
};

pub fn draw(parent: *vaxis.Window, opts: CalendarPanelDrawOpts) !vaxis.Window {
    const calendarPanelBorderColor = if (opts.isActivePanel)
        colors.activeBorderColor
    else
        colors.borderColor;

    var window = parent.child(.{
        .border = .{
            .where = .all,
            .style = .{ .fg = calendarPanelBorderColor },
        },
    });

    _ = try Calendar.draw(&window, .{ .cursorPosition = opts.calendarCursorPosition });

    return window;
}
