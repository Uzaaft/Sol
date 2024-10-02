const std = @import("std");
const CalendarView = @import("calendar-view.zig");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer {
        const deinit_status = gpa.deinit();
        if (deinit_status == .leak) {
            std.log.err("memory leak", .{});
        }
    }
    const allocator = gpa.allocator();

    var app = try CalendarView.App.init(allocator);
    defer app.deinit();

    try app.run();
}
