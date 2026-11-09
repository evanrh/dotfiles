ObjC.import('Foundation');
$.NSBundle.bundleWithPath('/System/Library/PrivateFrameworks/MediaRemote.framework/').load;

const R = $.NSClassFromString('MRNowPlayingRequest');
const info = R.localNowPlayingItem.nowPlayingInfo;
const get = k => {
  if (info.isNil()) return null;
  const v = info.objectForKey('kMRMediaRemoteNowPlayingInfo' + k);
  return v.isNil() ? null : ObjC.unwrap(v);
};

const MAX_LENGTH = 18;
const trunc_string = s => {
  if (s?.length > MAX_LENGTH) {
    return `${s.slice(0, MAX_LENGTH)}...`
  }
  return s
}

const title = get('Title');
const artist = get('Artist');
// Show the action, like a player button: pause while playing, play while paused
const icon = R.localIsPlaying ? '' : ''; // nf-fa-pause / nf-fa-play
// const icon = R.localIsPlaying ? '\uf28b' : '\uf144';
const cleanTitle = trunc_string(title)
const cleanArtist = trunc_string(artist)

cleanTitle ? `${[cleanTitle, cleanArtist].filter(Boolean).join(' - ')} ${icon}` : '';
