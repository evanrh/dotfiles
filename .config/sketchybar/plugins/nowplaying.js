ObjC.import('Foundation');
$.NSBundle.bundleWithPath('/System/Library/PrivateFrameworks/MediaRemote.framework/').load;

const R = $.NSClassFromString('MRNowPlayingRequest');
const info = R.localNowPlayingItem.nowPlayingInfo;
const get = k => {
  if (info.isNil()) return null;
  const v = info.objectForKey('kMRMediaRemoteNowPlayingInfo' + k);
  return v.isNil() ? null : ObjC.unwrap(v);
};

const title = get('Title');
const artist = get('Artist');
// Show the action, like a player button: pause while playing, play while paused
const icon = R.localIsPlaying ? '' : ''; // nf-fa-pause / nf-fa-play
// const icon = R.localIsPlaying ? '\uf28b' : '\uf144';

title ? `${[title, artist].filter(Boolean).join(' - ')} ${icon}` : '';
