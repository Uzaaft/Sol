const vaxis = @import("vaxis");
const colors = @import("../styles/colors.zig");
const Calendar = @import("calendar.zig");
const GridPosition = @import("../types/grid-position.zig").GridPosition;
const Padding = @import("../types/padding.zig").Padding;
const Label = @import("./components//label.zig");

pub const CalendarPanelDrawOpts = struct {
    isActivePanel: bool = false,
    calendarCursorPosition: GridPosition = .{ .x = 0, .y = 0 },
    label: []const u8 = "Calendar",
    padding: Padding = .{ .x = 1, .y = 1 },
};

pub fn draw(parent: *vaxis.Window, opts: CalendarPanelDrawOpts) !vaxis.Window {
    const borderColor = if (opts.isActivePanel)
        colors.activeBorderColor
    else
        colors.borderColor;

    var window = parent.child(.{
        .border = .{
            .where = .all,
            .style = .{ .fg = borderColor },
        },
    });
    _ = try Label.draw(parent, .{ .text = opts.label, .color = borderColor });

    var content = window.child(.{
        .x_off = opts.padding.x,
        .y_off = opts.padding.y,
    });

    _ = try Calendar.draw(&content, .{ .cursorPosition = opts.calendarCursorPosition });

    return window;
}
