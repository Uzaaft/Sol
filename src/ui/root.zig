const vaxis = @import("vaxis");
const Panel = @import("panel.zig").Panel;
const EventsPanel = @import("events-panel.zig").EventsPanel;
const CalendarPanel = @import("calendar-panel.zig").CalendarPanel;

pub const RootDrawOpts = struct {
    activePanel: Panel,
};

pub const Root = struct {
    vxWin: *vaxis.Window,
    eventsPanel: EventsPanel,
    calendarPanel: CalendarPanel,

    pub fn init(vxWin: *vaxis.Window) !Root {
        return .{
            .vxWin = vxWin,
            .eventsPanel = try EventsPanel.init(vxWin),
            .calendarPanel = try CalendarPanel.init(vxWin),
        };
    }

    pub fn deinit(self: *const Root) void {
        self.eventsPanel.deinit();
        self.calendarPanel.deinit();
    }

    pub fn draw(self: *const Root, opts: RootDrawOpts) void {
        self.eventsPanel.draw(.{ .isActivePanel = opts.activePanel == Panel.events });
        self.calendarPanel.draw(.{ .isActivePanel = opts.activePanel == Panel.calendar });
    }
};
