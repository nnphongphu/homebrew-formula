class Vips < Formula
  desc "Image processing library"
  homepage "https://github.com/libvips/libvips"
  url "https://github.com/libvips/libvips/releases/download/v8.14.1/vips-8.14.1.tar.xz"
  sha256 "5abde2a61f99ced7be4c32ccb13a654256eb7a0f6f0520ab61cc11412a1233fa"
  license "LGPL-2.1-or-later"
  revision 1

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    sha256 arm64_ventura:  "723f63554af72e8afe72639fd19fa0972b3045e87b76d239974457e97441236f"
    sha256 arm64_monterey: "99316e36756f6130aeb45e8a54f876d9f58f02ce3efd82fa7bfb11b52a3c3e36"
    sha256 arm64_big_sur:  "e8685da9f9fa3ad204e99e7c86cfcffadb270cfd0671bc3f0ff250001da06a0c"
    sha256 ventura:        "3efbc36e88e380c09af5366a6e4dfa47460aa4a4e6cba138b8dd419f995884e5"
    sha256 monterey:       "4aaab9204a4457ca2a4d7a9ba8be23df077c57707f91baaa325240506bad46c7"
    sha256 big_sur:        "036232ab9c3bae1ab8d29a7a61ecf128d3221d62b19b66fd5eed0bbef403bb5f"
    sha256 x86_64_linux:   "236dbc8946fb9088c709309c6ec382cc107dbb29c682f7ceaf5d4534ab4eb8dc"
  end

  depends_on "gobject-introspection" => :build
  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "pkg-config" => :build
  depends_on "gettext"
  depends_on "glib"
  depends_on "libexif"
  depends_on "libimagequant"
  depends_on "libspng"
  depends_on "mozjpeg"
  depends_on "orc"

  uses_from_macos "expat"
  uses_from_macos "zlib"

  fails_with gcc: "5"

  def install
    # mozjpeg needs to appear before libjpeg, otherwise it's not used
    ENV.prepend_path "PKG_CONFIG_PATH", Formula["mozjpeg"].opt_lib/"pkgconfig"

    mkdir "build" do
      system "meson", "-Ddeprecated=false", "-Dintrospection=false", "-Dintrospection=false", "-Dcplusplus=true", "-Dcplusplus=true", "-Dexamples=false", "-Ddoxygen=false", "-Dgtk_doc=false", "-Dmodules=disabled", "-Dvapi=false", "-Dcfitsio=disabled", "-Dcgif=disabled", "-Dexif=auto", "-Dfftw=disabled", "-Dfontconfig=disabled", "-Dgsf=disabled", "-Dheif=disabled", "-Dheif-module=disabled", "-Dimagequant=auto", "-Djpeg=auto", "-Djpeg-xl=disabled", "-Djpeg-xl-module=disabled", "-Dlcms=disabled", "-Dmagick=disabled", "-Dmagick-module=disabled", "-Dmatio=disabled", "-Dnifti=disabled", "-Dopenexr=disabled", "-Dopenjpeg=disabled", "-Dopenslide=disabled", "-Dopenslide-module=disabled", "-Dorc=auto", "-Dpangocairo=disabled", "-Dpdfium=disabled", "-Dpng=disabled", "-Dpoppler=disabled", "-Dpoppler-module=disabled", "-Dquantizr=disabled", "-Drsvg=disabled", "-Dspng=auto", "-Dtiff=disabled", "-Dwebp=disabled", "-Dppm=false", "-Danalyze=false", "-Dradiance=false", "-Dzlib=disabled", *std_meson_args, ".."
      system "ninja"
      system "ninja", "install"
    end
  end
end
