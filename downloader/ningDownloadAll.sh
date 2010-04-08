#!/bin/bash

if [ ! -e ningDownloader.py ]
     then
         echo "missing ningDownloader.py"
         exit
fi


NETWORK=$1
USERNAME=$2
PASSWORD=$3

echo "Ning Downloader batch for"
echo "Network: $NETWORK"
echo "Username: $USERNAME"
echo "Password: $PASSWORD"

TYPES="Comment UploadedFile User TopicCommenterLink GroupMembership Photo Topic Invitation BlogPost ProfileCustomizationCss Playlist ProfileCustomizationCustomCss ActivityLogItem Video GroupInvitation Track VideoPreviewFrame AudioAttachment VideoAttachment ProfileCustomizationImage Group FriendRequestMessage GroupIcon ImageAttachment OpenSocialAppData EventAttendee GroupInvitationRequest Album OpenSocialApp BlockedContactList Category Page Event EventCalendar PageLayout EventWidget BlogArchive AvatarGridImage Config Note ContactList"

for theType in $TYPES; do
    echo Downloading content of type $theType
    set -x # debug
    ./ningDownloader.py --network $NETWORK --username $USERNAME --password $PASSWORD --endpoint content --selector="type='$theType'"
    zip $theType-data.zip *$theType*.xml
    set +x # clear debug
done

echo "Now just mail us the ZIP archives in this directory.  Or run the following command and send us alldata.zip."
echo zip alldata.zip *-data.zip
