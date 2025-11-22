const std = @import("std");
pub fn main() !void {
    var stdin_buffer: [1024]u8 = undefined;
    var stdin = std.fs.File.stdin();
    var reader = stdin.reader(&stdin_buffer);

    try std.fs.File.stdout().writeAll("Choose mode (e/d [1] , brute [2]) : ");
    const modestr = try reader.interface.takeDelimiterExclusive('\n');
    const mode = try std.fmt.parseInt(u8, modestr, 10);

    switch (mode) {
        1 => {
            const file = try std.fs.cwd().openFile("danger/test.txt", .{ .mode = .read_write });
            defer file.close();

            var buffer: [1024]u8 = undefined;
            const bytes_len = try file.read(&buffer);

            const data = buffer[0..bytes_len];

            std.debug.print("data : {s}\n", .{data});

            var inpbuff: [1024]u8 = undefined;
            var inp_reader = stdin.reader(&inpbuff);
            try std.fs.File.stdout().writeAll("8 bit pass : ");
            const userpassstr = try inp_reader.interface.takeDelimiterExclusive('\n');

            const user_key: u8 = try std.fmt.parseInt(u8, userpassstr, 10);

            std.debug.print("Trying crypting/decrypting with {} key", .{user_key});

            for (data) |*byte| {
                byte.* ^= user_key;
            }

            try file.setEndPos(0);
            try file.seekTo(0);
            try file.writeAll(data);
        },

        2 => {
            const file = try std.fs.cwd().openFile("danger/test.txt", .{ .mode = .read_write });
            defer file.close();

            var buffer: [1024]u8 = undefined;
            const bytes_len = try file.read(&buffer);
            const data = buffer[0..bytes_len];

            std.debug.print("data : {s}\n", .{data});
            std.debug.print("Starting bruteforce (trying 8-bit passwords)\n", .{});

            for (0..256) |i| {
                var temp_buf: [1024]u8 = undefined;
                @memcpy(temp_buf[0..data.len], data);

                for (temp_buf[0..data.len]) |*byte| {
                    byte.* ^= @as(u8, @intCast(i));
                }
                std.debug.print("{} => {s}\n", .{ i, temp_buf[0..data.len] });
            }
        },

        else => {
            try std.fs.File.stdout().writeAll("Unknown Option\n");
        },
    }
}
