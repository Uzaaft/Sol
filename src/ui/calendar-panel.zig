const vaxis = @import("vaxis");
const colors = @import("../styles/colors.zig");

const dummyCalendar = @embedFile("../assets/dummy-calendar.txt");

pub const CalendarPanelDrawOpts = struct {
    isActivePanel: bool = false,
};

pub const CalendarPanel = struct {
    vxWin: *vaxis.Window,

    pub fn init(vxWin: *vaxis.Window) !CalendarPanel {
        return .{
            .vxWin = vxWin,
        };
    }

    pub fn deinit(self: *const CalendarPanel) void {
        _ = self;
    }

    pub fn draw(self: *const CalendarPanel, opts: CalendarPanelDrawOpts) void {
        const calendarPanelBorderColor = if (opts.isActivePanel)
            colors.activeBorderColor
        else
            colors.borderColor;

        const window = self.vxWin.child(.{
            .x_off = (self.vxWin.width / 2) + 1,
            .y_off = 0,
            .width = .{ .limit = self.vxWin.width / 2 },
            .border = .{
                .where = .all,
                .style = .{ .fg = calendarPanelBorderColor },
            },
        });
        _ = try window.printSegment(.{ .text = dummyCalendar }, .{});
    }
};
