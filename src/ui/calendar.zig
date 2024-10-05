const vaxis = @import("vaxis");

pub fn draw(win: *vaxis.Window) !void {
    // TODO: create container and draw cells inside that
    try drawCalendarHeaderRow(win);
}

const cellWidth: comptime_int = 4;

const CalendarCellDrawOpts = struct {
    x_off: usize,
    y_off: usize,
    text: []const u8,
};

fn drawCalendarCell(win: *vaxis.Window, opts: CalendarCellDrawOpts) !vaxis.Window {
    const window = win.child(.{
        .x_off = opts.x_off,
        .y_off = opts.y_off,
        .width = .{ .limit = cellWidth },
    });

    _ = try window.printSegment(.{ .text = opts.text }, .{});

    return window;
}

const CalendarRowDrawOpts = struct {
    y_off: usize,
    cellTexts: [7][]const u8,
};

fn drawCalendarRow(win: *vaxis.Window, opts: CalendarRowDrawOpts) !void {
    var x_off: usize = 0;

    // TODO: create rowContainer and draw cells inside that

    for (opts.cellTexts) |cellText| {
        _ = try drawCalendarCell(win, .{ .x_off = x_off, .y_off = opts.y_off, .text = cellText });
        x_off += cellWidth;
    }
}

fn drawCalendarHeaderRow(win: *vaxis.Window) !void {
    const days = [7][]const u8{ "Mon ", "Tue ", "Wed ", "Thu ", "Fri ", "Sat ", "Sun " };
    try drawCalendarRow(win, .{ .y_off = 0, .cellTexts = days });
}
