def identity(param):
    return param

def get_path(file):
    return file.path

def decompose_targets(list_of_targets, map_function = identity):
    output = []
    for target in list_of_targets:
        for element in target.files.to_list():
            output.append(map_function(element))
    return output

def _ts_grpc_compile_impl(ctx):
    print(ctx.attr._compiler)
    print(ctx.attr._plugin)
    print(ctx.attr._plugin.files.to_list())
    print(decompose_targets(ctx.attr.srcs, get_path))
    output_directory = ctx.actions.declare_directory(ctx.attr.name)
    ctx.actions.run(
        executable = ctx.executable._compiler,
        inputs = decompose_targets(ctx.attr.srcs) + ctx.attr._plugin.files.to_list(),
        outputs = [ output_directory ],
        arguments = [
            "--plugin='protoc-gen-ts=$(location @npm//grpc_tools_node_protoc_ts/bin:protoc-gen-ts)",
            "--js_out='import_style=es6,binary:'" + output_directory.path + "'",
            "--ts_out='binary:" + output_directory.path + "'",
            "--proto_path=.",
        ] + decompose_targets(ctx.attr.srcs, get_path)
    )
    print(ctx.bin_dir.path)
    return [DefaultInfo(files = depset([output_directory]))]

ts_grpc_compile = rule(
    implementation = _ts_grpc_compile_impl,
    attrs = {
        "srcs": attr.label_list(),
        "_compiler": attr.label(
            executable = True,
            cfg="exec",
            default="@npm//grpc-tools/bin:grpc_tools_node_protoc",
        ),
        "_plugin": attr.label(
            default="@npm//grpc_tools_node_protoc_ts/bin:protoc-gen-ts",
        ),
    },

)
