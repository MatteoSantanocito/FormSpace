<?php
    $client_id = '4e5ec5f49f504198805e6bd7285f5253';
    $client_secret = 'e0fec4ef01344931835066c3344654c1';

    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL, 'https://accounts.spotify.com/api/token' );
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);

    curl_setopt($ch, CURLOPT_POST, 1);

    curl_setopt($ch, CURLOPT_POSTFIELDS, 'grant_type=client_credentials');
    $head = array('Authorization: Basic '.base64_encode($client_id.':'.$client_secret));
    curl_setopt($ch, CURLOPT_HTTPHEADER, $head);
    $token = json_decode(curl_exec($ch), true);

    curl_close($ch);

    $query = urlencode($_GET["q"]);
    $url = 'https://api.spotify.com/v1/search?type=track&q='.$query;
    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL, $url);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);

    curl_setopt($ch, CURLOPT_HTTPHEADER, array('Authorization: Bearer '.$token['access_token']));
    $res=curl_exec($ch);
    curl_close($ch);

    echo $res;
?>
