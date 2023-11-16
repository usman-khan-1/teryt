require 'zip'

module Teryt
  class Client
    attr_reader :savon_client

    def initialize(username:, password:)
      @savon_client = Savon.client(
        wsdl: WSDL,
        wsse_auth: [username, password],
        use_wsa_headers: true,
      )
    end

    def czy_zalogowany
      savon_client.call(:czy_zalogowany, message: {})
    end

    def pobierz_date_aktualnego_kat_ulic
      savon_client.call(:pobierz_date_aktualnego_kat_ulic)
    end

    def pobierz_liste_wojewodztw(data_stanu: Date.today)
      savon_client
        .call(:pobierz_liste_wojewodztw, message: { "tns:DataStanu" => data_stanu })
        .to_hash
        .dig(:pobierz_liste_wojewodztw_response, :pobierz_liste_wojewodztw_result, :jednostka_terytorialna)
        .map { |attrs| JednostkaTerytorialna.new(**attrs) }
    end

    def pobierz_liste_powiatow(woj:, data_stanu: Date.today)
      savon_client
        .call(:pobierz_liste_powiatow, message: { "tns:Woj" => woj, "tns:DataStanu" => data_stanu })
        .to_hash
        .dig(:pobierz_liste_powiatow_response, :pobierz_liste_powiatow_result, :jednostka_terytorialna)
        .map { |attrs| JednostkaTerytorialna.new(**attrs) }
    end

    def pobierz_liste_gmin(woj:, pow:, data_stanu: Date.today)
      savon_client
        .call(:pobierz_liste_gmin, message: { "tns:Woj" => woj, "tns:Pow" => pow, "tns:DataStanu" => data_stanu })
        .to_hash
        .dig(:pobierz_liste_gmin_response, :pobierz_liste_gmin_result, :jednostka_terytorialna)
        .then { |result| Array.wrap(result) }
        .map { |attrs| JednostkaTerytorialna.new(**attrs) }
    end

    def pobierz_slownik_rodzajow_jednostek
      savon_client
        .call(:pobierz_slownik_rodzajow_jednostek, message: {})
        .to_hash
        .dig(:pobierz_slownik_rodzajow_jednostek_response, :pobierz_slownik_rodzajow_jednostek_result, :string)
    end

    def pobierz_liste_miejscowosci_w_rodzaju_gminy(symbol_woj:, symbol_pow:, symbol_gmi:, symbol_rodz:, data_stanu: Date.today)
      savon_client
        .call(:pobierz_liste_miejscowosci_w_rodzaju_gminy, message: { "tns:symbolWoj" => symbol_woj,
                                                                      "tns:symbolPow" => symbol_pow,
                                                                      "tns:symbolGmi" => symbol_gmi,
                                                                      "tns:symbolRodz" => symbol_rodz,
                                                                      "tns:DataStanu" => data_stanu })
        .to_hash
        .dig(:pobierz_liste_miejscowosci_w_rodzaju_gminy_response, :pobierz_liste_miejscowosci_w_rodzaju_gminy_result, :miejscowosc)
        .then { |result| Array.wrap(result) }
        .map { |attrs| Miejscowosc.new(**attrs) }
    end

    def pobierz_zmiany_ulic_urzedowy(stanod:, stando: Date.today)
      savon_client
        .call(:pobierz_zmiany_ulic_urzedowy, message: { "tns:stanod" => stanod, "tns:stando" => stando })
        .to_hash
        .dig(:pobierz_zmiany_ulic_urzedowy_response, :pobierz_zmiany_ulic_urzedowy_result, :plik_zawartosc)
        .then { |file_content| StringIO.new(Base64.decode64(file_content)) }
        .then { |io| Zip::InputStream.new(io).get_next_entry.get_input_stream.read }
    end
  end
end
