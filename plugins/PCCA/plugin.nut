///////////////////////////////////////////////////
//          PCCA Launcher intergration           //
///////////////////////////////////////////////////

class UserConfig {
    </ label="PCCA Theme", help="Using pcca theme ?", options="Yes, No", order=1 /> PCCA="Yes";
};

local config = fe.get_config();

fe.add_transition_callback( "pcca_integrations" );

function write_ln( f, line )
{
    local b = blob( line.len() );

    for (local i=0; i<line.len(); i++)
        b.writen( line[i], 'b' );

    f.writeblob( b );
}

function table_to_json(tbl) {
    local json = "{\n";
    local i = 0;
    local count = tbl.len();
    foreach (k, v in tbl) {
        json += "  \"" + k + "\": \"" + v + "\"";
        if (i < count - 1)
            json += ",\n";
        else
            json += "\n";
        i++;
    }
    json += "}";
    return json;
}

function pcca_integrations(ttype, var, ttime)
{
    switch (ttype)
    {
        case Transition.ToGame:
            medias_path = "";
            if (config["PCCA"] == "Yes" && "medias_path" in fe.nv) {
                medias_path = fe.nv["medias_path"]
            }
            local file = file("pcca_integration.json", "wb+");

            local gameInfo = {
                "Name": fe.game_info(Info.Name),
                "Title": fe.game_info(Info.Title),
                "Emulator": fe.game_info(Info.Emulator),
                "CloneOf": fe.game_info(Info.CloneOf),
                "Year": fe.game_info(Info.Year),
                "Manufacturer": fe.game_info(Info.Manufacturer),
                "Category": fe.game_info(Info.Category),
                "Players": fe.game_info(Info.Players),
                "Rotation": fe.game_info(Info.Rotation),
                "Control": fe.game_info(Info.Control),
                "Status": fe.game_info(Info.Status),
                "DisplayCount": fe.game_info(Info.DisplayCount),
                "DisplayType": fe.game_info(Info.DisplayType),
                "AltRomname": fe.game_info(Info.AltRomname),
                "AltTitle": fe.game_info(Info.AltTitle),
                "Extra": fe.game_info(Info.Extra),
                "Buttons": fe.game_info(Info.Buttons),
                "Series": fe.game_info(Info.Series),
                "Language": fe.game_info(Info.Language),
                "Region": fe.game_info(Info.Region),
                "Rating": fe.game_info(Info.Rating),
                "PlayedTime": fe.game_info(Info.PlayedTime),
                "PlayedCount": fe.game_info(Info.PlayedCount)
                "Overview": fe.game_info(Info.Overview),
                "MediaPath": medias_path
            };

            local json = table_to_json(gameInfo);
            write_ln(file, json);
            file.close();
        break;
    }
    return false;
}