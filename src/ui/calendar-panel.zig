const vaxis = @import("vaxis");
const colors = @import("../styles/colors.zig");
const Calendar = @import("calendar.zig");

const dummyCalendar = @embedFile("../assets/dummy-calendar.txt");

pub const CalendarPanelDrawOpts = struct {
    isActivePanel: bool = false,
};

pub fn draw(parent: *vaxis.Window, opts: CalendarPanelDrawOpts) !vaxis.Window {
    const calendarPanelBorderColor = if (opts.isActivePanel)
        colors.activeBorderColor
    else
        colors.borderColor;

    var window = parent.child(.{
        .x_off = 0,
        .y_off = 0,
        .border = .{
            .where = .all,
            .style = .{ .fg = calendarPanelBorderColor },
        },
    });
    // _ = try window.printSegment(.{ .text = dummyCalendar }, .{});

    try Calendar.draw(&window);

    return window;
}
