const vaxis = @import("vaxis");

pub const VerticalSplitLayout = struct {
    left: vaxis.Window,
    right: vaxis.Window,
};

pub fn draw(parent: *vaxis.Window) VerticalSplitLayout {
    const left = parent.child(.{
        .x_off = 0,
        .y_off = 0,
        .width = .{ .limit = parent.width / 2 },
    });
    const right = parent.child(.{
        .x_off = (parent.width / 2) + 1,
        .y_off = 0,
        .width = .{ .limit = parent.width / 2 },
    });

    return .{ .left = left, .right = right };
}
