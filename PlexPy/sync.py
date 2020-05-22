from plexapi.myplex import PlexServer
baseurl = 'http://app.plex.tv'
token = 'zXcXt_NA7sqzb-asdcRN'
session = 'd13e04ba-8a58-46c4-850e-eb1341897c25'
plex = PlexServer(baseurl, token,session)
for client in plex.clients():
    print(client.title)
