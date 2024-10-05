const vaxis = @import("vaxis");

pub fn draw(parent: *vaxis.Window) !vaxis.Window {
    var window = parent.child(.{});

    var titleRow = window.child(.{});
    var headerRow = window.child(.{ .y_off = 1 });
    var dateGrid = window.child(.{ .y_off = 2 });

    _ = try drawCalendarTitle(&titleRow);
    _ = try drawCalendarHeaderRow(&headerRow);
    _ = try drawCalendarDateGrid(&dateGrid);

    return window;
}

pub fn drawCalendarTitle(parent: *vaxis.Window) !vaxis.Window {
    var window = parent.child(.{});
    _ = try window.printSegment(.{ .text = "October 2024" }, .{});
    return window;
}

const cellWidth: comptime_int = 4;

const CalendarCellDrawOpts = struct {
    text: []const u8,
};

fn drawCalendarCell(parent: *vaxis.Window, opts: CalendarCellDrawOpts) !vaxis.Window {
    var window = parent.child(.{
        .width = .{ .limit = cellWidth },
    });

    _ = try window.printSegment(.{ .text = opts.text }, .{});

    return window;
}

const CalendarRowDrawOpts = struct {
    cellTexts: [7][]const u8,
};

fn drawCalendarRow(parent: *vaxis.Window, opts: CalendarRowDrawOpts) !vaxis.Window {
    var window = parent.child(.{});

    var x_off: usize = 0;
    for (opts.cellTexts) |cellText| {
        var cell = window.child(.{ .x_off = x_off });
        _ = try drawCalendarCell(&cell, .{ .text = cellText });

        x_off += cellWidth;
    }

    return window;
}

fn drawCalendarHeaderRow(parent: *vaxis.Window) !vaxis.Window {
    var window = parent.child(.{});

    const days = [7][]const u8{ "Mon ", "Tue ", "Wed ", "Thu ", "Fri ", "Sat ", "Sun " };
    _ = try drawCalendarRow(&window, .{ .cellTexts = days });

    return window;
}

// fn drawCalendarDateRow(parent: *vaxis.Window) !vaxis.Window {}

fn drawCalendarDateGrid(parent: *vaxis.Window) !vaxis.Window {
    var window = parent.child(.{});

    // const row1Dates = [7][]const u8{ "    ", "    ", "  1 ", "  2 ", "  3 ", "  4 ", "  5 " };
    // const row2Dates = [7][]const u8{ "  6 ", "  7 ", "  8 ", "  9 ", " 10 ", " 11 ", " 12 " };
    // const row3Dates = [7][]const u8{ " 13 ", " 14 ", " 15 ", " 16 ", " 17 ", " 18 ", " 19 " };
    // const row4Dates = [7][]const u8{ " 20 ", " 21 ", " 22 ", " 23 ", " 24 ", " 25 ", " 26 " };
    // const row5Dates = [7][]const u8{ " 27 ", " 28 ", " 29 ", " 30 ", " 31 ", "    ", "    " };

    // FIXME: Not like this, we need drawDateCell(...) because the cell needs info such as "isSelected", etc
    const rows = [5][7][]const u8{
        [7][]const u8{ "    ", "    ", "  1 ", "  2 ", "  3 ", "  4 ", "  5 " },
        [7][]const u8{ "  6 ", "  7 ", "  8 ", "  9 ", " 10 ", " 11 ", " 12 " },
        [7][]const u8{ " 13 ", " 14 ", " 15 ", " 16 ", " 17 ", " 18 ", " 19 " },
        [7][]const u8{ " 20 ", " 21 ", " 22 ", " 23 ", " 24 ", " 25 ", " 26 " },
        [7][]const u8{ " 27 ", " 28 ", " 29 ", " 30 ", " 31 ", "    ", "    " },
    };

    var y_off: usize = 0;

    for (rows) |row| {
        var rowContainer = window.child(.{ .y_off = y_off });
        _ = try drawCalendarRow(&rowContainer, .{ .cellTexts = row });
        y_off += 1;
    }

    return window;
}
