const vaxis = @import("vaxis");

pub fn draw(parent: *vaxis.Window) !vaxis.Window {
    var window = parent.child(.{});

    var titleRow = window.child(.{});
    var headerRow = window.child(.{ .y_off = 1 });

    _ = try drawCalendarTitle(&titleRow);
    _ = try drawCalendarHeaderRow(&headerRow);

    return window;
}

pub fn drawCalendarTitle(parent: *vaxis.Window) !vaxis.Window {
    var window = parent.child(.{});
    _ = try window.printSegment(.{ .text = "October 2024" }, .{});
    return window;
}

const cellWidth: comptime_int = 4;

const CalendarCellDrawOpts = struct {
    x_off: usize,
    y_off: usize,
    text: []const u8,
};

fn drawCalendarCell(parent: *vaxis.Window, opts: CalendarCellDrawOpts) !vaxis.Window {
    var window = parent.child(.{
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

fn drawCalendarRow(parent: *vaxis.Window, opts: CalendarRowDrawOpts) !vaxis.Window {
    var window = parent.child(.{});

    var x_off: usize = 0;
    for (opts.cellTexts) |cellText| {
        _ = try drawCalendarCell(&window, .{ .x_off = x_off, .y_off = opts.y_off, .text = cellText });
        x_off += cellWidth;
    }

    return window;
}

fn drawCalendarHeaderRow(parent: *vaxis.Window) !vaxis.Window {
    const days = [7][]const u8{ "Mon ", "Tue ", "Wed ", "Thu ", "Fri ", "Sat ", "Sun " };
    return try drawCalendarRow(parent, .{ .y_off = 0, .cellTexts = days });
}
