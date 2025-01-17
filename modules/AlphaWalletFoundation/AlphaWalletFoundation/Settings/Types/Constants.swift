// Copyright SIX DAY LLC. All rights reserved.

import Foundation
import BigInt

public struct Constants {
    static let xdaiDropPrefix = Data(bytes: [0x58, 0x44, 0x41, 0x49, 0x44, 0x52, 0x4F, 0x50]).hex()
    
    static let bombMagicLinkHost = "bomb.app"
    static let mainnetMagicLinkHost = "eth.bomb.app"
    static let legacyMagicLinkHost = "legacy.bomb.app"
    static let classicMagicLinkHost = "classic.bomb.app"
    static let callistoMagicLinkHost = "callisto.bomb.app"
    static let poaMagicLinkHost = "poa.bomb.app"
    static let xDaiMagicLinkHost = "xdai.bomb.app"
    static let goerliMagicLinkHost = "goerli.bomb.app"
    static let artisSigma1MagicLinkHost = "artis_sigma1.bomb.app"
    static let artisTau1MagicLinkHost = "artis_tau1.bomb.app"
    static let binanceMagicLinkHost = "binance.bomb.app"
    static let binanceTestMagicLinkHost = "test-binance.bomb.app"
    static let hecoMagicLinkHost = "heco.bomb.app"
    static let hecoTestMagicLinkHost = "test-heco.bomb.app"
    static let customMagicLinkHost = "custom.bomb.app"
    static let fantomMagicLinkHost = "fantom.bomb.app"
    static let fantomTestMagicLinkHost = "test-fantom.bomb.app"
    static let avalancheMagicLinkHost = "avalanche.bomb.app"
    static let avalancheTestMagicLinkHost = "test-avalanche.bomb.app"
    static let maticMagicLinkHost = "polygon.bomb.app"
    static let mumbaiTestMagicLinkHost = "test-polygon.bomb.app"
    static let optimisticMagicLinkHost = "optimistic.bomb.app"
    static let cronosMagicLinkHost = "cronos.bomb.app"
    static let cronosTestMagicLinkHost = "test-cronos.bomb.app"
    static let arbitrumMagicLinkHost = "arbitrum.bomb.app"
    static let palmMagicLinkHost = "palm.bomb.app"
    static let palmTestnetMagicLinkHost = "palmTestnet.bomb.app"
    static let klaytnCypressMagicLinkHost = "klaytnCypress.bomb.app"
    static let klaytnBaobabTestnetMagicLinkHost = "klaytnBaobabTestnet.bomb.app"
    static let ioTeXMagicLinkHost = "ioTeX.bomb.app"
    static let ioTeXTestnetMagicLinkHost = "ioTeXTestnet.bomb.app"
    static let optimismGoerliMagicLinkHost = "optimismGoerli.bomb.app"
    static let arbitrumGoerliMagicLinkHost = "arbitrumGoerli.bomb.app"

    // Magic link networks
    public static let legacyMagicLinkPrefix = "https://app.awallet.io/"

        
    // fee master
    static let paymentServerBaseUrl = URL(string: "https://paymaster.stormbird.sg")!

    //Ethereum null variables
    public static let nullTokenId = "0x0000000000000000000000000000000000000000000000000000000000000000"
    public static let nullTokenIdBigUInt = BigUInt(0)
    public static let burnAddressString = "0x000000000000000000000000000000000000dEaD"
   public static let bombchainBtcb = AlphaWallet.Address(string: "0x140F62aCCC69cb24eABdC0E00b7caaC577cA5b24")!
    public static let nullAddress = AlphaWallet.Address(uncheckedAgainstNullAddress: "0x0000000000000000000000000000000000000000")!
    public static let nativeCryptoAddressInDatabase = nullAddress

    // FIFA hardcoded FIFA token address
    public static let ticketContractAddress = AlphaWallet.Address(string: "0xA66A3F08068174e8F005112A8b2c7A507a822335")!
    static let ticketContractAddressRopsten = AlphaWallet.Address(string: "0xD8e5F58DE3933E1E35f9c65eb72cb188674624F3")!

    // UEFA hardcoded addresses
    static let uefaMainnet = (AlphaWallet.Address(string: "0x89D142Bef8605646881C68dcD48cDAF17FE597dC")!, RPCServer.main)
    static let gnoGnosis = (AlphaWallet.Address(string: "0x9c58bacc331c9aa871afd802db6379a98e80cedb")!, RPCServer.xDai)

    static let unstoppableDomainsV2API = URL(string: "https://resolve.unstoppabledomains.com")!
    static let unstoppableDomainsRecordKeys = ["crypto.MATIC.version.MATIC.address", "crypto.ETH.address", "crypto.MATIC.version.ERC20.address"]
    //Using "kat" instead of "cryptokitties" to avoid being mistakenly detected by app review as supporting CryptoKitties
    static let katContractAddress = "0x06012c8cf97bead5deae237070f9587f8e7a266d"
    public static let katNameFallback = "AlphaWallet.katNameFallback"

    //xDai dapps
    static let xDaiBridge = URL(string: "https://bridge.xdaichain.com/")!
    static let arbitrumBridge = URL(string: "https://bridge.arbitrum.io/")!

    static func buyWithRampUrl(asset: String, wallet: Wallet) -> String? {
        guard Constants.Credentials.rampApiKey.nonEmpty else { return nil }
        return "https://buy.ramp.network/?hostApiKey=\(Constants.Credentials.rampApiKey)&hostLogoUrl=https%3A%2F%2Falphawallet.com%2Fwp-content%2Fthemes%2Falphawallet%2Fimg%2Flogo-horizontal-new.svg&hostAppName=AlphaWallet&swapAsset=\(asset)&userAddress=\(wallet.address.eip55String)"
    }

    static func buyWithCoinbaseUrl(blockchain: String, wallet: Wallet) -> String? {
        guard Features.default.isAvailable(.isCoinbasePayEnabled) else { return nil }
        guard Constants.Credentials.coinbaseAppId.nonEmpty else { return nil }
        let base = "https://pay.coinbase.com/buy/select-asset?appId=\(Constants.Credentials.coinbaseAppId)"
        return base + ("&destinationWallets=[{\"address\": \"\(wallet.address.eip55String)\",\"blockchains\":[\"\(blockchain)\"]}]".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "")
    }

    static let highStandardEthereumMainnetGasThresholdGwei = BigInt(130)

    static let legacy875Addresses = [AlphaWallet.Address(string: "0x830e1650a87a754e37ca7ed76b700395a7c61614")!,
                                            AlphaWallet.Address(string: "0xa66a3f08068174e8f005112a8b2c7a507a822335")!]
    static let legacy721Addresses = [
        AlphaWallet.Address(string: "0x06012c8cf97bead5deae237070f9587f8e7a266d")!,
        AlphaWallet.Address(string: "0xabc7e6c01237e8eef355bba2bf925a730b714d5f")!,
        AlphaWallet.Address(string: "0x71c118b00759b0851785642541ceb0f4ceea0bd5")!,
        AlphaWallet.Address(string: "0x7fdcd2a1e52f10c28cb7732f46393e297ecadda1")!
    ]

    static let ensContractOnMainnet = AlphaWallet.Address.ethereumAddress(eip55String: "0x57f1887a8BF19b14fC0dF6Fd9B2acc9Af147eA85")

    public static let defaultEnabledServers: [RPCServer] = [.bomb, .binance_smart_chain]
    public static let defaultEnabledTestnetServers: [RPCServer] = []

    enum TokenScript {
        static let urlSchemeForResources = "tokenscript-resource:///"
        static let validatorAPI = "https://aw.app/api/v1/verifyXMLDSig"
    }

    enum Enjin {
        static let apiUrl = URL(string: "https://cloud.enjin.io/graphql/default")!
    }

    enum BlockscanChat {
        static let blockscanChatWebUrl = URL(string: "https://chat.blockscan.com/login")!
        static let unreadCountBaseUrl = URL(string: "https://blockscan-chat-proxy.herokuapp.com")!
    }

    enum Coingecko {
        static let baseUrl = URL(string: "https://api.coingecko.com")!
    }

    enum OneInch {
        static let exchangeUrl = URL(string: "https://api.1inch.exchange")!
    }

    enum HoneySwap {
        static let exchangeUrl = URL(string: "https://tokens.honeyswap.org/")!
    }

    enum Ramp {
        static let exchangeUrl = URL(string: "https://api-instant.ramp.network")!
    }

    enum Covalent {
        static let apiBaseUrl = URL(string: "https://api.covalenthq.com")!
        static let newlyAddedTransactionUpdateInterval: TimeInterval = 15
        static let newlyAddedTransactionsPerPage = 100
        static let oldestTransactionUpdateInterval: TimeInterval = 25
        static let oldestAddedTransactionsPerPage = 500
        static let pendingTransactionUpdateInterval: TimeInterval = 5
    }

    enum ChainState {
        static let getChainStateInterval: TimeInterval = 6
    }

    enum Ens {
        static let recordExpiration: TimeInterval = -(2 * 24 * 60 * 60)
    }

    enum Image {
        static let numberOfCharactersOfSymbolToShowInIcon = 4
    }

    enum Phi {
        static let baseUrl = URL(string: "https://price.phi.network")!
    }

    //CurrencyFormatter
    public static let formatterFractionDigits = 2

    //EtherNumberFormatter
    public static let etherFormatterFractionDigits = 4

    public static let defaultSortTokensParams: [SortTokensParam] =  [
        .byField(field: .name, direction: .ascending),
        .byField(field: .name, direction: .descending),
        .byField(field: .value, direction: .ascending),
        .byField(field: .value, direction: .descending)
    ]
}
