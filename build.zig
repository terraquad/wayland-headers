const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const module = b.createModule(.{
        .target = target,
        .optimize = optimize,
    });
    module.addCSourceFile(.{
        .file = b.addWriteFiles().add("empty.c", ""),
    });

    const lib = b.addLibrary(.{
        .name = "wayland-headers",
        .root_module = module,
        .linkage = .static,
    });
    lib.installHeadersDirectory(b.path("wayland"), "wayland", .{});
    lib.installHeadersDirectory(b.path("wayland-protocols"), "wayland-protocols", .{});
    lib.installHeadersDirectory(b.path("libdecor"), "libdecor", .{});
    b.installArtifact(lib);
}
