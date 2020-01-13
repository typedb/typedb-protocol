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
    {"artifact": "com.google.android:annotations:4.1.1.4", "lang": "java", "sha1": "a1678ba907bf92691d879fef34e1a187038f9259", "sha256": "ba734e1e84c09d615af6a09d33034b4f0442f8772dec120efb376d86a565ae15", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/google/android/annotations/4.1.1.4/annotations-4.1.1.4.jar", "source": {"sha1": "deb22daeb37bdcbc14230aeaeddce38320d6d0f9", "sha256": "e9b667aa958df78ea1ad115f7bbac18a5869c3128b1d5043feb360b0cfce9d40", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/google/android/annotations/4.1.1.4/annotations-4.1.1.4-sources.jar"} , "name": "com-google-android-annotations", "actual": "@com-google-android-annotations//jar", "bind": "jar/com/google/android/annotations"},
    {"artifact": "com.google.api.grpc:proto-google-common-protos:1.12.0", "lang": "java", "sha1": "1140cc74df039deb044ed0e320035e674dc13062", "sha256": "bd60cd7a423b00fb824c27bdd0293aaf4781be1daba6ed256311103fb4b84108", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/google/api/grpc/proto-google-common-protos/1.12.0/proto-google-common-protos-1.12.0.jar", "source": {"sha1": "af18069b1d8368ffc8dce50a919df75f039cf507", "sha256": "936fdc055855a956ef82afb1b408bd0bd5ea5d040fe6f6fc25c4955879db649a", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/google/api/grpc/proto-google-common-protos/1.12.0/proto-google-common-protos-1.12.0-sources.jar"} , "name": "com-google-api-grpc-proto-google-common-protos", "actual": "@com-google-api-grpc-proto-google-common-protos//jar", "bind": "jar/com/google/api/grpc/proto-google-common-protos"},
# duplicates in com.google.code.findbugs:jsr305 promoted to 3.0.2
# - com.google.guava:guava:23.0 wanted version 1.3.9
# - io.grpc:grpc-api:1.24.1 wanted version 3.0.2
# - io.perfmark:perfmark-api:0.17.0 wanted version 3.0.2
    {"artifact": "com.google.code.findbugs:jsr305:3.0.2", "lang": "java", "sha1": "25ea2e8b0c338a877313bd4672d3fe056ea78f0d", "sha256": "766ad2a0783f2687962c8ad74ceecc38a28b9f72a2d085ee438b7813e928d0c7", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/google/code/findbugs/jsr305/3.0.2/jsr305-3.0.2.jar", "source": {"sha1": "b19b5927c2c25b6c70f093767041e641ae0b1b35", "sha256": "1c9e85e272d0708c6a591dc74828c71603053b48cc75ae83cce56912a2aa063b", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/google/code/findbugs/jsr305/3.0.2/jsr305-3.0.2-sources.jar"} , "name": "com-google-code-findbugs-jsr305", "actual": "@com-google-code-findbugs-jsr305//jar", "bind": "jar/com/google/code/findbugs/jsr305"},
    {"artifact": "com.google.code.gson:gson:2.7", "lang": "java", "sha1": "751f548c85fa49f330cecbb1875893f971b33c4e", "sha256": "2d43eb5ea9e133d2ee2405cc14f5ee08951b8361302fdd93494a3a997b508d32", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/google/code/gson/gson/2.7/gson-2.7.jar", "source": {"sha1": "bbb63ca253b483da8ee53a50374593923e3de2e2", "sha256": "2d3220d5d936f0a26258aa3b358160741a4557e046a001251e5799c2db0f0d74", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/google/code/gson/gson/2.7/gson-2.7-sources.jar"} , "name": "com-google-code-gson-gson", "actual": "@com-google-code-gson-gson//jar", "bind": "jar/com/google/code/gson/gson"},
# duplicates in com.google.errorprone:error_prone_annotations promoted to 2.3.2
# - com.google.guava:guava:23.0 wanted version 2.0.18
# - io.grpc:grpc-api:1.24.1 wanted version 2.3.2
# - io.perfmark:perfmark-api:0.17.0 wanted version [2.3.2,2.3.3]
    {"artifact": "com.google.errorprone:error_prone_annotations:2.3.2", "lang": "java", "sha1": "d1a0c5032570e0f64be6b4d9c90cdeb103129029", "sha256": "357cd6cfb067c969226c442451502aee13800a24e950fdfde77bcdb4565a668d", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/google/errorprone/error_prone_annotations/2.3.2/error_prone_annotations-2.3.2.jar", "source": {"sha1": "6e986bccd3d116d8bc1aaac8534d068ea8edd2ae", "sha256": "7ce688ed1582a67097228c050192b7cfd00479a81d2b921f7cd5116994f1402d", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/google/errorprone/error_prone_annotations/2.3.2/error_prone_annotations-2.3.2-sources.jar"} , "name": "com-google-errorprone-error_prone_annotations", "actual": "@com-google-errorprone-error_prone_annotations//jar", "bind": "jar/com/google/errorprone/error-prone-annotations"},
    {"artifact": "com.google.guava:guava:23.0", "lang": "java", "sha1": "c947004bb13d18182be60077ade044099e4f26f1", "sha256": "7baa80df284117e5b945b19b98d367a85ea7b7801bd358ff657946c3bd1b6596", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/google/guava/guava/23.0/guava-23.0.jar", "source": {"sha1": "ed233607c5c11e1a13a3fd760033ed5d9fe525c2", "sha256": "37fe8ba804fb3898c3c8f0cbac319cc9daa58400e5f0226a380ac94fb2c3ca14", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/google/guava/guava/23.0/guava-23.0-sources.jar"} , "name": "com-google-guava-guava", "actual": "@com-google-guava-guava//jar", "bind": "jar/com/google/guava/guava"},
    {"artifact": "com.google.j2objc:j2objc-annotations:1.1", "lang": "java", "sha1": "ed28ded51a8b1c6b112568def5f4b455e6809019", "sha256": "2994a7eb78f2710bd3d3bfb639b2c94e219cedac0d4d084d516e78c16dddecf6", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/google/j2objc/j2objc-annotations/1.1/j2objc-annotations-1.1.jar", "source": {"sha1": "1efdf5b737b02f9b72ebdec4f72c37ec411302ff", "sha256": "2cd9022a77151d0b574887635cdfcdf3b78155b602abc89d7f8e62aba55cfb4f", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/google/j2objc/j2objc-annotations/1.1/j2objc-annotations-1.1-sources.jar"} , "name": "com-google-j2objc-j2objc-annotations", "actual": "@com-google-j2objc-j2objc-annotations//jar", "bind": "jar/com/google/j2objc/j2objc-annotations"},
    {"artifact": "com.google.protobuf:protobuf-java:3.5.1", "lang": "java", "sha1": "8c3492f7662fa1cbf8ca76a0f5eb1146f7725acd", "sha256": "b5e2d91812d183c9f053ffeebcbcda034d4de6679521940a19064714966c2cd4", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/google/protobuf/protobuf-java/3.5.1/protobuf-java-3.5.1.jar", "source": {"sha1": "7235a28a13938050e8cd5d9ed5133bebf7a4dca7", "sha256": "3be3115498d543851443bfa725c0c5b28140e363b3b7dec97f4028cd17040fa4", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/google/protobuf/protobuf-java/3.5.1/protobuf-java-3.5.1-sources.jar"} , "name": "com-google-protobuf-protobuf-java", "actual": "@com-google-protobuf-protobuf-java//jar", "bind": "jar/com/google/protobuf/protobuf-java"},
# duplicates in io.grpc:grpc-api fixed to 1.24.1
# - io.grpc:grpc-core:1.24.1 wanted version [1.24.1]
# - io.grpc:grpc-protobuf-lite:1.24.1 wanted version 1.24.1
# - io.grpc:grpc-protobuf:1.24.1 wanted version 1.24.1
# - io.grpc:grpc-stub:1.24.1 wanted version 1.24.1
    {"artifact": "io.grpc:grpc-api:1.24.1", "lang": "java", "sha1": "7bbdb6041e82a741804378160a90a4f41cac696b", "sha256": "72d0609aad504b4cf1ed6e4579aca2c7a4ecef0a9eafe74efa1c4337b0fcfc59", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/io/grpc/grpc-api/1.24.1/grpc-api-1.24.1.jar", "source": {"sha1": "82256fc6c75fe38a4e03f9d358398b07fc2bd047", "sha256": "3f69b54b7d79ef8651df504517e296a2f09d29c5c32a51c21049d4bc537767d4", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/io/grpc/grpc-api/1.24.1/grpc-api-1.24.1-sources.jar"} , "name": "io-grpc-grpc-api", "actual": "@io-grpc-grpc-api//jar", "bind": "jar/io/grpc/grpc-api"},
    {"artifact": "io.grpc:grpc-context:1.24.1", "lang": "java", "sha1": "77485a74c2553ae0efeefd8917d4b09ccecb0465", "sha256": "c5e0210385eb81f8fe51f1308cbcf35b123b615f930da11d77ed4e0711c6572f", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/io/grpc/grpc-context/1.24.1/grpc-context-1.24.1.jar", "source": {"sha1": "bd796a3185b1928dde644006f3e8200fdd1ca0c3", "sha256": "0ea66e060362c94874ea25604cbf2040ecfb2ca9b00bd44bee2f28a91b2f2ee3", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/io/grpc/grpc-context/1.24.1/grpc-context-1.24.1-sources.jar"} , "name": "io-grpc-grpc-context", "actual": "@io-grpc-grpc-context//jar", "bind": "jar/io/grpc/grpc-context"},
    {"artifact": "io.grpc:grpc-core:1.24.1", "lang": "java", "sha1": "16abedf794f6597f3839b452d1b32438a53a6781", "sha256": "4d32143b729c589e0e4772c42a62abda350449d6459b234a65e60a7ade26f81c", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/io/grpc/grpc-core/1.24.1/grpc-core-1.24.1.jar", "source": {"sha1": "fb5d30f462d244d208a71c266fb9db5eabf01f21", "sha256": "3436698f4715e95bb7c3f023962b109eb1924004e9b6a06a4bff67c3fd9964f4", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/io/grpc/grpc-core/1.24.1/grpc-core-1.24.1-sources.jar"} , "name": "io-grpc-grpc-core", "actual": "@io-grpc-grpc-core//jar", "bind": "jar/io/grpc/grpc-core"},
    {"artifact": "io.grpc:grpc-protobuf-lite:1.24.1", "lang": "java", "sha1": "0ae3345903b0ba1de89ffa25890f54ec08e5380b", "sha256": "43b0e1d54c6bc1992646b49ad16ede5b4603c8a7df2c84ced6f44902c421d688", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/io/grpc/grpc-protobuf-lite/1.24.1/grpc-protobuf-lite-1.24.1.jar", "source": {"sha1": "fcbb0399ef5a257962874eeb9deb5add0d5437bc", "sha256": "746919ad5911d0c185055af903b4f7ed7cd32eb6a6c9a0004c9819d04fa35bb0", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/io/grpc/grpc-protobuf-lite/1.24.1/grpc-protobuf-lite-1.24.1-sources.jar"} , "name": "io-grpc-grpc-protobuf-lite", "actual": "@io-grpc-grpc-protobuf-lite//jar", "bind": "jar/io/grpc/grpc-protobuf-lite"},
    {"artifact": "io.grpc:grpc-protobuf:1.24.1", "lang": "java", "sha1": "b4794f4b135ea38dbac8816803065cf4e8f77ed6", "sha256": "855f1c66aaa634ab04fe374e36d585c08cc82e4aa0dda0a58c2b9a98d7224673", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/io/grpc/grpc-protobuf/1.24.1/grpc-protobuf-1.24.1.jar", "source": {"sha1": "5731e519bcb62341a2cc3724c5d0f4880012cb11", "sha256": "33819268846bcb82169d5e6e9f6f64788bf9fb96c28b16d3528bc65051ec6b4d", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/io/grpc/grpc-protobuf/1.24.1/grpc-protobuf-1.24.1-sources.jar"} , "name": "io-grpc-grpc-protobuf", "actual": "@io-grpc-grpc-protobuf//jar", "bind": "jar/io/grpc/grpc-protobuf"},
    {"artifact": "io.grpc:grpc-stub:1.24.1", "lang": "java", "sha1": "08e0b4b6ea6d8bc99de3da7d79c2168ff90f5d13", "sha256": "e29424943abe1936112b14e2f703107dfa0df8f0612968a11837b5aec650a24f", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/io/grpc/grpc-stub/1.24.1/grpc-stub-1.24.1.jar", "source": {"sha1": "12c4720c09f0613bf86dfe62c09ca2c1fdde8180", "sha256": "fab3f26d0667e099443eae255cc9dedab465167a9aea1f1b3bcbd266046cac65", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/io/grpc/grpc-stub/1.24.1/grpc-stub-1.24.1-sources.jar"} , "name": "io-grpc-grpc-stub", "actual": "@io-grpc-grpc-stub//jar", "bind": "jar/io/grpc/grpc-stub"},
    {"artifact": "io.opencensus:opencensus-api:0.21.0", "lang": "java", "sha1": "73c07fe6458840443f670b21c7bf57657093b4e1", "sha256": "8e2cb0f6391d8eb0a1bcd01e7748883f0033b1941754f4ed3f19d2c3e4276fc8", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/io/opencensus/opencensus-api/0.21.0/opencensus-api-0.21.0.jar", "source": {"sha1": "cb401f202129b5d990b84b18fe6b25fb64c8e828", "sha256": "a185e02627df9dd25ac982f8f1e81f6ac059550d82b0e8c149f9954bd750ad7f", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/io/opencensus/opencensus-api/0.21.0/opencensus-api-0.21.0-sources.jar"} , "name": "io-opencensus-opencensus-api", "actual": "@io-opencensus-opencensus-api//jar", "bind": "jar/io/opencensus/opencensus-api"},
    {"artifact": "io.opencensus:opencensus-contrib-grpc-metrics:0.21.0", "lang": "java", "sha1": "f07d3a325f1fe69ee40d6b409086964edfef4e69", "sha256": "29fc79401082301542cab89d7054d2f0825f184492654c950020553ef4ff0ef8", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/io/opencensus/opencensus-contrib-grpc-metrics/0.21.0/opencensus-contrib-grpc-metrics-0.21.0.jar", "source": {"sha1": "00526747acfe2def936f115b70909cb23af7cb47", "sha256": "6536dcddc505c73c53d8e031f12276dfd345b093a59c1943d050bf55dba4730f", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/io/opencensus/opencensus-contrib-grpc-metrics/0.21.0/opencensus-contrib-grpc-metrics-0.21.0-sources.jar"} , "name": "io-opencensus-opencensus-contrib-grpc-metrics", "actual": "@io-opencensus-opencensus-contrib-grpc-metrics//jar", "bind": "jar/io/opencensus/opencensus-contrib-grpc-metrics"},
    {"artifact": "io.perfmark:perfmark-api:0.17.0", "lang": "java", "sha1": "97e81005e3a7f537366ffdf20e11e050303b58c1", "sha256": "816c11409b8a0c6c9ce1cda14bed526e7b4da0e772da67c5b7b88eefd41520f9", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/io/perfmark/perfmark-api/0.17.0/perfmark-api-0.17.0.jar", "source": {"sha1": "de7f5ee703568965c414179c285232310f6c73c9", "sha256": "f5997eb93866f30fe2c573cec5ac6a78e1049ee94a196f637fb458c62559ad1f", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/io/perfmark/perfmark-api/0.17.0/perfmark-api-0.17.0-sources.jar"} , "name": "io-perfmark-perfmark-api", "actual": "@io-perfmark-perfmark-api//jar", "bind": "jar/io/perfmark/perfmark-api"},
# duplicates in org.codehaus.mojo:animal-sniffer-annotations promoted to 1.17
# - com.google.guava:guava:23.0 wanted version 1.14
# - io.grpc:grpc-api:1.24.1 wanted version 1.17
    {"artifact": "org.codehaus.mojo:animal-sniffer-annotations:1.17", "lang": "java", "sha1": "f97ce6decaea32b36101e37979f8b647f00681fb", "sha256": "92654f493ecfec52082e76354f0ebf87648dc3d5cec2e3c3cdb947c016747a53", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/codehaus/mojo/animal-sniffer-annotations/1.17/animal-sniffer-annotations-1.17.jar", "source": {"sha1": "8fb5b5ad9c9723951b9fccaba5bb657fa6064868", "sha256": "2571474a676f775a8cdd15fb9b1da20c4c121ed7f42a5d93fca0e7b6e2015b40", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/codehaus/mojo/animal-sniffer-annotations/1.17/animal-sniffer-annotations-1.17-sources.jar"} , "name": "org-codehaus-mojo-animal-sniffer-annotations", "actual": "@org-codehaus-mojo-animal-sniffer-annotations//jar", "bind": "jar/org/codehaus/mojo/animal-sniffer-annotations"},
    ]

def maven_dependencies(callback = jar_artifact_callback):
    for hash in list_dependencies():
        callback(hash)
