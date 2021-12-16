using LibPQ, Tables, Dates
using SHA
using JSON

function creatConnection()
    return LibPQ.Connection("dbname=klingelbeutel")
end


function createuser(_login::String, _vorname::String, _nachname::String, _email::String, password::String )
    conn = creatConnection()
    execute(conn, "BEGIN;")
    p = bytes2hex(sha256(password))
    sql = "INSERT INTO app_user(login, vorname, nachname, email, password)values(\$1, \$2, \$3, \$4, \$5)"
    LibPQ.load!((login=[_login], vorname=[_vorname], nachname=[_nachname], email=[_email], password=[p]),conn, sql)
    execute(conn, "COMMIT;")
end

function getNews()
    conn = creatConnection()
    sql = "select url, news_short, news_text, datum from news order by datum desc limit 10;"
    result = execute(conn, sql)
    data = columntable(result)
    ergo_array = []
    for i in 1:length(data[2])
        row = Dict("news_short" => data[2][i],"news_text" => data[3][i], "datum" => data[4][i] )
        push!(ergo_array,row)

    end
    println(JSON.json(ergo_array))

    
    println(data[2][1])
    println(length(data[2]))
end


getNews()
#createuser("tom", "Thomas", "Schmidt", "t_schmidt@web.de", "Geheim#1")