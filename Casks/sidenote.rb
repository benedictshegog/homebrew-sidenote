cask "sidenote" do
  version "0.1.10"
  sha256 "6dc8b85e7da138c85f4b8a25a1b55c21444cb791835f2de991e6f19aff351fa7"

  url "https://benedictshegog.xyz/downloads/Sidenote_#{version}_aarch64.dmg"
  name "Sidenote"
  desc "Review markdown from Claude Code: WYSIWYG editing, comments, replies in place"
  homepage "https://benedictshegog.xyz/"

  depends_on arch: :arm64
  depends_on macos: :ventura

  app "Sidenote.app"
  binary "#{appdir}/Sidenote.app/Contents/MacOS/sidenote"

  # Unsigned build: clear the quarantine flag so Gatekeeper does not block it.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Sidenote.app"],
                   sudo: false

    # Launch it on a first install, so `brew install` ends with the app on
    # screen rather than silence. The app creates ~/.sidenote at startup, so
    # its absence means this machine has never run it; an upgrade therefore
    # stays quiet instead of stealing focus from whatever you are doing.
    unless File.exist?(File.expand_path("~/.sidenote"))
      system_command "/usr/bin/open",
                     args: ["-a", "#{appdir}/Sidenote.app"],
                     sudo: false
    end
  end

  zap trash: [
    "~/.claude/skills/sidenote-review",
    "~/.sidenote",
    "~/Library/Caches/com.benedictshegog.sidenote",
    "~/Library/Preferences/com.benedictshegog.sidenote.plist",
    "~/Library/WebKit/com.benedictshegog.sidenote",
  ]

  caveats <<~EOS
    Sidenote #{version} is installed at #{appdir}/Sidenote.app.

    A first install opens it for you. Afterwards, launch it from Spotlight or:
      open -a Sidenote

    On first launch it offers to link the `sidenote` command, add the Claude
    Code skill, and make Sidenote the default app for .md files. It installs
    none of those without your say.

    Your comments and snapshots live in ~/.sidenote. A plain uninstall leaves
    them alone; only `--zap` removes them.
  EOS
end
