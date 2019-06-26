# Do not edit. bazel-deps autogenerates this file from dependencies/maven/dependencies.yaml.
def _jar_artifact_impl(ctx):
    jar_name = "%s.jar" % ctx.name
    ctx.download(
        output=ctx.path("jar/%s" % jar_name),
        url=ctx.attr.urls,
        sha256=ctx.attr.sha256,
        executable=False
    )
    src_name="%s-sources.jar" % ctx.name
    srcjar_attr=""
    has_sources = len(ctx.attr.src_urls) != 0
    if has_sources:
        ctx.download(
            output=ctx.path("jar/%s" % src_name),
            url=ctx.attr.src_urls,
            sha256=ctx.attr.src_sha256,
            executable=False
        )
        srcjar_attr ='\n    srcjar = ":%s",' % src_name

    build_file_contents = """
package(default_visibility = ['//visibility:public'])
java_import(
    name = 'jar',
    tags = ['maven_coordinates={artifact}'],
    jars = ['{jar_name}'],{srcjar_attr}
)
filegroup(
    name = 'file',
    srcs = [
        '{jar_name}',
        '{src_name}'
    ],
    visibility = ['//visibility:public']
)\n""".format(artifact = ctx.attr.artifact, jar_name = jar_name, src_name = src_name, srcjar_attr = srcjar_attr)
    ctx.file(ctx.path("jar/BUILD"), build_file_contents, False)
    return None

jar_artifact = repository_rule(
    attrs = {
        "artifact": attr.string(mandatory = True),
        "sha256": attr.string(mandatory = True),
        "urls": attr.string_list(mandatory = True),
        "src_sha256": attr.string(mandatory = False, default=""),
        "src_urls": attr.string_list(mandatory = False, default=[]),
    },
    implementation = _jar_artifact_impl
)

def jar_artifact_callback(hash):
    src_urls = []
    src_sha256 = ""
    source=hash.get("source", None)
    if source != None:
        src_urls = [source["url"]]
        src_sha256 = source["sha256"]
    jar_artifact(
        artifact = hash["artifact"],
        name = hash["name"],
        urls = [hash["url"]],
        sha256 = hash["sha256"],
        src_urls = src_urls,
        src_sha256 = src_sha256
    )
    native.bind(name = hash["bind"], actual = hash["actual"])


def list_dependencies():
    return [
    {"artifact": "com.google.api.grpc:proto-google-common-protos:1.0.0", "lang": "java", "sha1": "86f070507e28b930e50d218ee5b6788ef0dd05e6", "sha256": "cfe1da4c0e82820c32a83c4bf25b42f4d3b7113177321c437a9fff3c42e1f4c9", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/google/api/grpc/proto-google-common-protos/1.0.0/proto-google-common-protos-1.0.0.jar", "source": {"sha1": "b48d52024623007eaf1a5636c28f3699a8a078a5", "sha256": "0d016cc4677bb7bb721ebf862f3cd07e7df9710a677c3412081887c786756d73", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/google/api/grpc/proto-google-common-protos/1.0.0/proto-google-common-protos-1.0.0-sources.jar"} , "name": "com-google-api-grpc-proto-google-common-protos", "actual": "@com-google-api-grpc-proto-google-common-protos//jar", "bind": "jar/com/google/api/grpc/proto-google-common-protos"},
# duplicates in com.google.code.findbugs:jsr305 promoted to 3.0.2
# - com.google.guava:guava:23.0 wanted version 1.3.9
# - io.grpc:grpc-core:1.16.0 wanted version 3.0.2
    {"artifact": "com.google.code.findbugs:jsr305:3.0.2", "lang": "java", "sha1": "25ea2e8b0c338a877313bd4672d3fe056ea78f0d", "sha256": "766ad2a0783f2687962c8ad74ceecc38a28b9f72a2d085ee438b7813e928d0c7", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/google/code/findbugs/jsr305/3.0.2/jsr305-3.0.2.jar", "source": {"sha1": "b19b5927c2c25b6c70f093767041e641ae0b1b35", "sha256": "1c9e85e272d0708c6a591dc74828c71603053b48cc75ae83cce56912a2aa063b", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/google/code/findbugs/jsr305/3.0.2/jsr305-3.0.2-sources.jar"} , "name": "com-google-code-findbugs-jsr305", "actual": "@com-google-code-findbugs-jsr305//jar", "bind": "jar/com/google/code/findbugs/jsr305"},
    {"artifact": "com.google.code.gson:gson:2.7", "lang": "java", "sha1": "751f548c85fa49f330cecbb1875893f971b33c4e", "sha256": "2d43eb5ea9e133d2ee2405cc14f5ee08951b8361302fdd93494a3a997b508d32", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/google/code/gson/gson/2.7/gson-2.7.jar", "source": {"sha1": "bbb63ca253b483da8ee53a50374593923e3de2e2", "sha256": "2d3220d5d936f0a26258aa3b358160741a4557e046a001251e5799c2db0f0d74", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/google/code/gson/gson/2.7/gson-2.7-sources.jar"} , "name": "com-google-code-gson-gson", "actual": "@com-google-code-gson-gson//jar", "bind": "jar/com/google/code/gson/gson"},
# duplicates in com.google.errorprone:error_prone_annotations promoted to 2.2.0
# - com.google.guava:guava:23.0 wanted version 2.0.18
# - io.grpc:grpc-core:1.16.0 wanted version 2.2.0
# - io.opencensus:opencensus-api:0.12.3 wanted version 2.2.0
# - io.opencensus:opencensus-contrib-grpc-metrics:0.12.3 wanted version 2.2.0
    {"artifact": "com.google.errorprone:error_prone_annotations:2.2.0", "lang": "java", "sha1": "88e3c593e9b3586e1c6177f89267da6fc6986f0c", "sha256": "6ebd22ca1b9d8ec06d41de8d64e0596981d9607b42035f9ed374f9de271a481a", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/google/errorprone/error_prone_annotations/2.2.0/error_prone_annotations-2.2.0.jar", "source": {"sha1": "a8cd7823aa1dcd2fd6677c0c5988fdde9d1fb0a3", "sha256": "626adccd4894bee72c3f9a0384812240dcc1282fb37a87a3f6cb94924a089496", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/google/errorprone/error_prone_annotations/2.2.0/error_prone_annotations-2.2.0-sources.jar"} , "name": "com-google-errorprone-error_prone_annotations", "actual": "@com-google-errorprone-error_prone_annotations//jar", "bind": "jar/com/google/errorprone/error-prone-annotations"},
    {"artifact": "com.google.guava:guava:23.0", "lang": "java", "sha1": "c947004bb13d18182be60077ade044099e4f26f1", "sha256": "7baa80df284117e5b945b19b98d367a85ea7b7801bd358ff657946c3bd1b6596", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/google/guava/guava/23.0/guava-23.0.jar", "source": {"sha1": "ed233607c5c11e1a13a3fd760033ed5d9fe525c2", "sha256": "37fe8ba804fb3898c3c8f0cbac319cc9daa58400e5f0226a380ac94fb2c3ca14", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/google/guava/guava/23.0/guava-23.0-sources.jar"} , "name": "com-google-guava-guava", "actual": "@com-google-guava-guava//jar", "bind": "jar/com/google/guava/guava"},
    {"artifact": "com.google.j2objc:j2objc-annotations:1.1", "lang": "java", "sha1": "ed28ded51a8b1c6b112568def5f4b455e6809019", "sha256": "2994a7eb78f2710bd3d3bfb639b2c94e219cedac0d4d084d516e78c16dddecf6", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/google/j2objc/j2objc-annotations/1.1/j2objc-annotations-1.1.jar", "source": {"sha1": "1efdf5b737b02f9b72ebdec4f72c37ec411302ff", "sha256": "2cd9022a77151d0b574887635cdfcdf3b78155b602abc89d7f8e62aba55cfb4f", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/google/j2objc/j2objc-annotations/1.1/j2objc-annotations-1.1-sources.jar"} , "name": "com-google-j2objc-j2objc-annotations", "actual": "@com-google-j2objc-j2objc-annotations//jar", "bind": "jar/com/google/j2objc/j2objc-annotations"},
    {"artifact": "com.google.protobuf:protobuf-java:3.4.0", "lang": "java", "sha1": "b32aba0cbe737a4ca953f71688725972e3ee927c", "sha256": "dce7e66b32456a1b1198da0caff3a8acb71548658391e798c79369241e6490a4", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/google/protobuf/protobuf-java/3.4.0/protobuf-java-3.4.0.jar", "source": {"sha1": "c57c9f6bcbdb783260d00b80c455d82a6a8b02db", "sha256": "07a55d5d34d2b47d2d1d9092be1dbf1b1d99fffcea19b7eafba508de8daae2cd", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/google/protobuf/protobuf-java/3.4.0/protobuf-java-3.4.0-sources.jar"} , "name": "com-google-protobuf-protobuf-java", "actual": "@com-google-protobuf-protobuf-java//jar", "bind": "jar/com/google/protobuf/protobuf-java"},
    {"artifact": "io.grpc:grpc-context:1.16.0", "lang": "java", "sha1": "c979cb271666193f5ce7e704cbf9328d82eec14c", "sha256": "e6d2df6ccc8274093c8e42c23a9f600fb88f10581e7cd5a027936c64c01ba44b", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/io/grpc/grpc-context/1.16.0/grpc-context-1.16.0.jar", "source": {"sha1": "d191e7a7eb9c2ec451d29c2d2a3a1774ab745b54", "sha256": "ca6d28dc2722aa1aac1b8e0cb9d415381104d5ff31f51fc48883252c68f3c291", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/io/grpc/grpc-context/1.16.0/grpc-context-1.16.0-sources.jar"} , "name": "io-grpc-grpc-context", "actual": "@io-grpc-grpc-context//jar", "bind": "jar/io/grpc/grpc-context"},
    {"artifact": "io.grpc:grpc-core:1.16.0", "lang": "java", "sha1": "eb2dbfedffb5f2ce9ada9a1577d3e01be0a6cd77", "sha256": "33d6ccd6bb6168e107cffa6bedac1f16939ac65d3f60839568ab96eeb70e0597", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/io/grpc/grpc-core/1.16.0/grpc-core-1.16.0.jar", "source": {"sha1": "48b139d706b0dc9e8ce48d9d0b8bd334cb884801", "sha256": "35e2bf94559382b2961f5edae69f1331bfabf37fdde450050ed1430047a8949a", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/io/grpc/grpc-core/1.16.0/grpc-core-1.16.0-sources.jar"} , "name": "io-grpc-grpc-core", "actual": "@io-grpc-grpc-core//jar", "bind": "jar/io/grpc/grpc-core"},
    {"artifact": "io.grpc:grpc-protobuf-lite:1.16.0", "lang": "java", "sha1": "77776a41c4408c59e921cc26647736c1567f0807", "sha256": "5a3ecfcef5db15640088b3c71b2ee12aeaef5e27af03fcf6059b2cd935bdcc47", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/io/grpc/grpc-protobuf-lite/1.16.0/grpc-protobuf-lite-1.16.0.jar", "source": {"sha1": "ad67bda2c05080b0010020626b3ac94aa49106f6", "sha256": "8066d1eac0bdbffec3eace3ed290aeb25f1b87839f85f6ad1ab799cf02680697", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/io/grpc/grpc-protobuf-lite/1.16.0/grpc-protobuf-lite-1.16.0-sources.jar"} , "name": "io-grpc-grpc-protobuf-lite", "actual": "@io-grpc-grpc-protobuf-lite//jar", "bind": "jar/io/grpc/grpc-protobuf-lite"},
    {"artifact": "io.grpc:grpc-protobuf:1.16.0", "lang": "java", "sha1": "a49b55f8fb9ffe26b7464db5db0c0b4d874d5107", "sha256": "7f2995d3e1c3cf7cf6c0afed14f6822f7b641d31099ddd42f15cedc4f1fcb02f", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/io/grpc/grpc-protobuf/1.16.0/grpc-protobuf-1.16.0.jar", "source": {"sha1": "ee63b53c0458cc71a2bcc291db8aae8a63afb714", "sha256": "909691a5c7f20e870cb1c4e85510410a195932e7d9b6d7e8e57d88a6c3d2b8f7", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/io/grpc/grpc-protobuf/1.16.0/grpc-protobuf-1.16.0-sources.jar"} , "name": "io-grpc-grpc-protobuf", "actual": "@io-grpc-grpc-protobuf//jar", "bind": "jar/io/grpc/grpc-protobuf"},
    {"artifact": "io.grpc:grpc-stub:1.16.0", "lang": "java", "sha1": "5dd67cad593ccd7cce3f76c9cdd2c2afa259c7bb", "sha256": "c1a6bdae606c11810ff2d452d2c37d7334b4aa283a126b2ea6a62527382a4dbe", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/io/grpc/grpc-stub/1.16.0/grpc-stub-1.16.0.jar", "source": {"sha1": "42d2f5ed27e06bfcc258cb92646d4dadd638ea5f", "sha256": "5fc735b9ae273b2b84ce7039f45b87011d54d42553a8721f6fc3af8bc806b312", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/io/grpc/grpc-stub/1.16.0/grpc-stub-1.16.0-sources.jar"} , "name": "io-grpc-grpc-stub", "actual": "@io-grpc-grpc-stub//jar", "bind": "jar/io/grpc/grpc-stub"},
    {"artifact": "io.opencensus:opencensus-api:0.12.3", "lang": "java", "sha1": "743f074095f29aa985517299545e72cc99c87de0", "sha256": "8c1de62cbdaf74b01b969d1ed46c110bca1a5dd147c50a8ab8c5112f42ced802", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/io/opencensus/opencensus-api/0.12.3/opencensus-api-0.12.3.jar", "source": {"sha1": "09c2dad7aff8b6d139723b9181ba5da3f689213b", "sha256": "67e8b2120737c7dcfc61eef33f75319b1c4e5a2806d3c1a74cab810650ac7a19", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/io/opencensus/opencensus-api/0.12.3/opencensus-api-0.12.3-sources.jar"} , "name": "io-opencensus-opencensus-api", "actual": "@io-opencensus-opencensus-api//jar", "bind": "jar/io/opencensus/opencensus-api"},
    {"artifact": "io.opencensus:opencensus-contrib-grpc-metrics:0.12.3", "lang": "java", "sha1": "a4c7ff238a91b901c8b459889b6d0d7a9d889b4d", "sha256": "632c1e1463db471b580d35bc4be868facbfbf0a19aa6db4057215d4a68471746", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/io/opencensus/opencensus-contrib-grpc-metrics/0.12.3/opencensus-contrib-grpc-metrics-0.12.3.jar", "source": {"sha1": "9a7d004b774700837eeebff61230b8662d0e30d1", "sha256": "d54f6611f75432ca0ab13636a613392ae8b7136ba67eb1588fccdb8481f4d665", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/io/opencensus/opencensus-contrib-grpc-metrics/0.12.3/opencensus-contrib-grpc-metrics-0.12.3-sources.jar"} , "name": "io-opencensus-opencensus-contrib-grpc-metrics", "actual": "@io-opencensus-opencensus-contrib-grpc-metrics//jar", "bind": "jar/io/opencensus/opencensus-contrib-grpc-metrics"},
# duplicates in org.codehaus.mojo:animal-sniffer-annotations promoted to 1.17
# - com.google.guava:guava:23.0 wanted version 1.14
# - io.grpc:grpc-core:1.16.0 wanted version 1.17
    {"artifact": "org.codehaus.mojo:animal-sniffer-annotations:1.17", "lang": "java", "sha1": "f97ce6decaea32b36101e37979f8b647f00681fb", "sha256": "92654f493ecfec52082e76354f0ebf87648dc3d5cec2e3c3cdb947c016747a53", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/codehaus/mojo/animal-sniffer-annotations/1.17/animal-sniffer-annotations-1.17.jar", "source": {"sha1": "8fb5b5ad9c9723951b9fccaba5bb657fa6064868", "sha256": "2571474a676f775a8cdd15fb9b1da20c4c121ed7f42a5d93fca0e7b6e2015b40", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/codehaus/mojo/animal-sniffer-annotations/1.17/animal-sniffer-annotations-1.17-sources.jar"} , "name": "org-codehaus-mojo-animal-sniffer-annotations", "actual": "@org-codehaus-mojo-animal-sniffer-annotations//jar", "bind": "jar/org/codehaus/mojo/animal-sniffer-annotations"},
    ]

def maven_dependencies(callback = jar_artifact_callback):
    for hash in list_dependencies():
        callback(hash)
