import {
	faAndroid,
	faApple,
	faDebian,
	faFedora,
	faOpensuse,
	faUbuntu,
	faWindows,
	faRedhat,
} from "@fortawesome/free-brands-svg-icons";
import type { IconDefinition } from "@fortawesome/free-brands-svg-icons/index";
import { Home, Newspaper, Download } from "lucide-svelte";

export const routes: Record<string, [string, any]> = {
	"/": ["Home", Home],
	"/blog": ["Blog", Newspaper],
	"/downloads": ["Downloads", Download],
	"/about": ["About", null],
};

const releasesUrl =
	"https://github.com/KRTirtho/Pyro Music/releases/latest/download";

export const downloadLinks: Record<string, [string, IconDefinition[]]> = {
	"Android Apk": [`${releasesUrl}/Pyro Music-android-all-arch.apk`, [faAndroid]],
	"Windows Executable": [
		`${releasesUrl}/Pyro Music-windows-x86_64-setup.exe`,
		[faWindows],
	],
	"macOS Dmg": [`${releasesUrl}/Pyro Music-macos-universal.dmg`, [faApple]],
	"Ubuntu, Debian": [
		`${releasesUrl}/Pyro Music-linux-x86_64.deb`,
		[faUbuntu, faDebian],
	],
	"Fedora, Redhat, Opensuse": [
		`${releasesUrl}/Pyro Music-linux-x86_64.rpm`,
		[faFedora, faRedhat, faOpensuse],
	],
	"iPhone Ipa": [`${releasesUrl}/Pyro Music-iOS.ipa`, [faApple]],
};

export const extendedDownloadLinks: Record<
	string,
	[string, IconDefinition[], string]
> = {
	Android: [`${releasesUrl}/Pyro Music-android-all-arch.apk`, [faAndroid], "apk"],
	Windows: [
		`${releasesUrl}/Pyro Music-windows-x86_64-setup.exe`,
		[faWindows],
		"exe",
	],
	macOS: [`${releasesUrl}/Pyro Music-macos-universal.dmg`, [faApple], "dmg"],
	"Ubuntu, Debian": [
		`${releasesUrl}/Pyro Music-linux-x86_64.deb`,
		[faUbuntu, faDebian],
		"deb",
	],
	"Fedora, Redhat, Opensuse": [
		`${releasesUrl}/Pyro Music-linux-x86_64.rpm`,
		[faFedora, faRedhat, faOpensuse],
		"rpm",
	],
	iPhone: [`${releasesUrl}/Pyro Music-iOS.ipa`, [faApple], "ipa"],
};

const nightlyReleaseUrl =
	"https://github.com/KRTirtho/Pyro Music/releases/download/nightly";

export const extendedNightlyDownloadLinks: Record<
	string,
	[string, IconDefinition[], string]
> = {
	Android: [
		`${nightlyReleaseUrl}/Pyro Music-android-all-arch.apk`,
		[faAndroid],
		"apk",
	],
	Windows: [
		`${nightlyReleaseUrl}/Pyro Music-windows-x86_64-setup.exe`,
		[faWindows],
		"exe",
	],
	macOS: [`${nightlyReleaseUrl}/Pyro Music-macos-universal.dmg`, [faApple], "dmg"],
	"Ubuntu, Debian": [
		`${nightlyReleaseUrl}/Pyro Music-linux-x86_64.deb`,
		[faUbuntu, faDebian],
		"deb",
	],
	"Fedora, Redhat, Opensuse": [
		`${nightlyReleaseUrl}/Pyro Music-linux-x86_64.rpm`,
		[faFedora, faRedhat, faOpensuse],
		"rpm",
	],
	iPhone: [`${nightlyReleaseUrl}/Pyro Music-iOS.ipa`, [faApple], "ipa"],
};

export const ADS_SLOTS = Object.freeze({
	rootPageDisplay: 5979549631,
	blogPageInFeed: 3386010031,
	downloadPageDisplay: 9928443050,
  packagePageArticle: 9119323068,
  // This is being used for rehype-auto-ads in svelte.config.js
  blogArticlePageArticle: 6788673194,
});
