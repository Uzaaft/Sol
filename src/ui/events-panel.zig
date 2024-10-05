const vaxis = @import("vaxis");
const colors = @import("../styles/colors.zig");

const dummyEvents = @embedFile("../assets/dummy-events.txt");

pub const EventsPanelDrawOpts = struct {
    isActivePanel: bool = true,
};

pub const EventsPanel = struct {
    vxWin: *vaxis.Window,

    pub fn init(vxWin: *vaxis.Window) !EventsPanel {
        return .{
            .vxWin = vxWin,
        };
    }

    pub fn deinit(self: *const EventsPanel) void {
        _ = self;
    }

    pub fn draw(self: *const EventsPanel, opts: EventsPanelDrawOpts) void {
        const eventsPanelBorderColor = if (opts.isActivePanel)
            colors.activeBorderColor
        else
            colors.borderColor;

        const window = self.vxWin.child(.{
            .x_off = 0,
            .y_off = 0,
            .width = .{ .limit = self.vxWin.width / 2 },
            .border = .{
                .where = .all,
                .style = .{ .fg = eventsPanelBorderColor },
            },
        });

        _ = try window.printSegment(.{ .text = dummyEvents }, .{});
    }
};
