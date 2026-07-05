cask "code-manager" do
  version "1.3.1"
  sha256 "fe68a0947583789402ddd52473b80bda3c701ae41309b6e8409d06d6147fba4b"

  url "https://github.com/maguowei/code-manager/releases/download/v#{version}/code-manager_#{version}_universal.dmg"
  name "Code Manager"
  desc "Local desktop config manager for Claude Code"
  homepage "https://github.com/maguowei/code-manager"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :big_sur

  app "code-manager.app"

  # 未公证：安装后移除隔离属性，避免 Gatekeeper 首启拦截
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/code-manager.app"]
  end

  zap trash: [
    "~/.config/code-manager",
    "~/Library/Application Support/com.gotobeta.app.code-manager",
    "~/Library/Caches/com.gotobeta.app.code-manager",
    "~/Library/Logs/com.gotobeta.app.code-manager",
    "~/Library/Saved Application State/com.gotobeta.app.code-manager.savedState",
    "~/Library/WebKit/com.gotobeta.app.code-manager",
  ]
end
