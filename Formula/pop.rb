class Pop < Formula
  desc "Swiss-army knife for Polkadot development"
  homepage "https://github.com/r0gue-io/pop-cli"
  version "0.11.0"
  license "GPL-3.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/r0gue-io/pop-cli/releases/download/v0.11.0/pop-aarch64-apple-darwin.tar.gz"
      sha256 "eb793770fa5b07fb1f158d547d997ce573fb66d7ced309f29f84b6157a584948"
    else
      url "https://github.com/r0gue-io/pop-cli/releases/download/v0.11.0/pop-x86_64-apple-darwin.tar.gz"
      sha256 "08da5394b53b6bc91163bc05274c2025aa5178dba6941bf625b9d26f65cb74b4"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/r0gue-io/pop-cli/releases/download/v0.11.0/pop-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "52b981e540cd49893237437ecaacb0f5cc6ed554266ee9dc258cae34d37781ff"
    else
      url "https://github.com/r0gue-io/pop-cli/releases/download/v0.11.0/pop-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "c3f8b5de751719c10c253134cc5fc797d217fbedb40b24bacf242afb415eb7f2"
    end
  end

  def install
    bin.install "pop"
  end

  test do
    system "#{bin}/pop", "--version"
  end
end
