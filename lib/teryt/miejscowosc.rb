module Teryt
  class Miejscowosc
    attr_reader :nazwa, :symbol, :wojewodztwo, :woj_symbol, :powiat, :pow_symbol, :gmina, :gmi_symbol, :gmi_rodzaj

    def initialize(nazwa:, symbol:, wojewodztwo:, woj_symbol:, powiat:, pow_symbol:, gmina:, gmi_symbol:, gmi_rodzaj:)
      @nazwa = nazwa 
      @symbol = symbol 
      @wojewodztwo = wojewodztwo 
      @woj_symbol = woj_symbol 
      @powiat = powiat 
      @pow_symbol = pow_symbol 
      @gmina = gmina 
      @gmi_symbol = gmi_symbol 
      @gmi_rodzaj = gmi_rodzaj
    end
  end
end
