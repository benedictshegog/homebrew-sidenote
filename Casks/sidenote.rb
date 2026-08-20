cask "sidenote" do
  version "0.1.2"
  sha256 "391a14b0ef20f4f0e8d025bea1bb983cd5af4e6ce94a5f1e9b3a546863384e7d"

  url "https://github.com/benedictshegog/sidenote/releases/download/v#{version}/Sidenote_#{version}_aarch64.dmg"
  name "Sidenote"
  desc "Review markdown written by Claude Code: WYSIWYG editing, comments, replies in place"
  homepage "https://github.com/benedictshegog/sidenote"

  depends_on arch: :arm64
  depends_on macos: ">= :ventura"

  app "Sidenote.app"
  binary "#{appdir}/Sidenote.app/Contents/MacOS/sidenote"

  # Unsigned build: clear the quarantine flag so Gatekeeper does not block it.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Sidenote.app"],
                   sudo: false
  end

  zap trash: [
    "~/.sidenote",
    "~/.claude/skills/sidenote-review",
  ]
end
