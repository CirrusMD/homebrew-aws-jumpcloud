class AwsJumpcloud < Formula
  include Language::Python::Virtualenv

  desc "aws-vault like tool for JumpCloud authentication"
  homepage "https://github.com/CirrusMD/aws-jumpcloud"
  url "https://github.com/CirrusMD/aws-jumpcloud/releases/download/v2.1.10/aws_jumpcloud-2.1.10.tar.gz"
  version "v2.1.10"
  sha256 "9f4389aef0c3d1013f43b3f7e955901ff499c5c6a82c075c1f4210a56f0c0306"
  head "https://github.com/CirrusMD/aws-jumpcloud.git", :branch => 'main'
  depends_on "python@3.8"

  def install
    venv = virtualenv_create(libexec, "python3")
    system libexec/"bin/pip3", "install", "-v", "--ignore-installed", buildpath
    system libexec/"bin/pip3", "uninstall", "-y", "aws-jumpcloud"
    venv.pip_install_and_link buildpath
  end

  def caveats; <<~EOS
    Use aws-jumpcloud --help to see available commands

    Check out the README to look into migrating existing ~/.aws credentials:

      https://github.com/CirrusMD/aws-jumpcloud/blob/main/README.md#migrating-from-aws-credentials

  EOS
  end

  test do
    assert_match "rotate", shell_output("#{bin}/aws-jumpcloud help")
  end
end
