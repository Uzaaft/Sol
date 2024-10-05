const std = @import("std");
const vaxis = @import("vaxis");
const GridPosition = @import("../types/grid-position.zig").GridPosition;

const CalendarDrawOpts = struct {
    cursorPosition: GridPosition = .{ .x = 0, .y = 0 },
};

pub fn draw(parent: *vaxis.Window, opts: CalendarDrawOpts) !vaxis.Window {
    var window = parent.child(.{});

    var titleRow = window.child(.{});
    var headerRow = window.child(.{ .y_off = 1 });
    var dateGrid = window.child(.{ .y_off = 2 });

    _ = try drawCalendarTitle(&titleRow);
    _ = try drawCalendarHeaderRow(&headerRow);
    _ = try drawCalendarDateGrid(&dateGrid, .{ .cursorPosition = opts.cursorPosition });

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

const CalendarDateCellDrawOpts = struct {
    date: []const u8,
    isSelected: bool = false,
};

fn drawCalendarDateCell(parent: *vaxis.Window, opts: CalendarDateCellDrawOpts) !vaxis.Window {
    var window = parent.child(.{
        .width = .{ .limit = cellWidth },
    });

    _ = try window.printSegment(.{ .text = opts.date }, .{});

    if (opts.isSelected) {
        _ = try window.printSegment(.{ .text = "[" }, .{ .col_offset = 0 });
        _ = try window.printSegment(.{ .text = "]" }, .{ .col_offset = 3 });
    }

    return window;
}

const CalendarRowDrawOpts = struct {
    cellTexts: [7][]const u8,
    isCursorInRow: bool = false,
    cursorCol: usize = 0,
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

const DrawCalendarDateRowOpts = struct {
    cellTexts: [7][]const u8,
    isCursorInRow: bool = false,
    cursorCol: usize = 0,
};

fn drawCalendarDateRow(parent: *vaxis.Window, opts: DrawCalendarDateRowOpts) !vaxis.Window {
    var window = parent.child(.{});

    var x_off: usize = 0;
    for (opts.cellTexts, 0..) |cellText, col| {
        var cell = window.child(.{ .x_off = x_off });
        _ = try drawCalendarDateCell(&cell, .{
            .date = cellText,
            .isSelected = opts.isCursorInRow and opts.cursorCol == col,
        });

        x_off += cellWidth;
    }

    return window;
}

const DrawCalendarDateGridOpts = struct {
    cursorPosition: GridPosition = .{ .x = 0, .y = 0 },
};

fn drawCalendarDateGrid(parent: *vaxis.Window, opts: DrawCalendarDateGridOpts) !vaxis.Window {
    var window = parent.child(.{});

    const rows = [5][7][]const u8{
        [7][]const u8{ "  ", "  ", " 1", " 2", " 3", " 4", " 5" },
        [7][]const u8{ " 6", " 7", " 8", " 9", "10", "11", "12" },
        [7][]const u8{ "13", "14", "15", "16", "17", "18", "19" },
        [7][]const u8{ "20", "21", "22", "23", "24", "25", "26" },
        [7][]const u8{ "27", "28", "29", "30", "31", "  ", "  " },
    };

    var y_off: usize = 0;

    for (rows, 0..) |row, rowIdx| {
        var rowContainer = window.child(.{ .y_off = y_off });
        _ = try drawCalendarDateRow(&rowContainer, .{
            .cellTexts = row,
            .isCursorInRow = opts.cursorPosition.y == rowIdx,
            .cursorCol = opts.cursorPosition.x,
        });
        y_off += 1;
    }

    return window;
}
