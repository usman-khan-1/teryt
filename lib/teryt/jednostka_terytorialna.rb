module Teryt
  class JednostkaTerytorialna
    attr_reader :gmi, :nazwa, :nazwa_dod, :pow, :rodz, :stan_na, :woj

    def initialize(gmi:, nazwa:, nazwa_dod:, pow:, rodz:, stan_na:, woj:)
      @gmi = gmi
      @nazwa = nazwa
      @nazwa_dod = nazwa_dod
      @pow = pow
      @rodz = rodz
      @stan_na = stan_na
      @woj = woj
    end
  end
end
