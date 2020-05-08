using BinDeps
@BinDeps.setup

visa = library_dependency("visa", aliases = ["visa64","VISA","/Library/Frameworks/VISA.framework/VISA", "librsvisa"])
# librsvisa is the specific Rohde & Schwarz VISA library name
visa_path_found = BinDeps._find_library(visa)

if ~isempty(visa_path_found)
    @BinDeps.install Dict(:visa=>:libvisa)
else
    @warn "No VISA libraries found, please check VISA installation for visa64 library!"
end

