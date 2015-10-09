using BinDeps
@BinDeps.setup

visa = library_dependency("visa", aliases = ["visa64","VISA","/Library/Frameworks/VISA.framework/VISA"])

@BinDeps.install Dict(:visa=>:libvisa)
