cask "sidenote" do
  version "0.1.1"
  sha256 "398ec6caa037ff0e9c34d633913ad71cc8109734a9e5839326131cabf8f009dd"

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
