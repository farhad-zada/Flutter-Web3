import 'package:flutter/material.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? data;
  @override
  Widget build(BuildContext context) {
    String apiUrl = 'https://data-seed-prebsc-1-s1.binance.org:8545/';
    EthPrivateKey fromHex = EthPrivateKey.fromHex(
      '3b658b3735797ee267cfdfb33e164a45ddd53085d3b77764412e5e4b0bf8819f',
    );
    var httpClient = Client();
    var ethClient = Web3Client(apiUrl, httpClient);

    final contract = DeployedContract(
        ContractAbi.fromJson(
            '[  {   "anonymous": false,   "inputs": [    {     "indexed": true,     "internalType": "address",     "name": "owner",     "type": "address"    },    {     "indexed": true,     "internalType": "address",     "name": "spender",     "type": "address"    },    {     "indexed": false,     "internalType": "uint256",     "name": "value",     "type": "uint256"    }   ],   "name": "Approval",   "type": "event"  },  {   "anonymous": false,   "inputs": [    {     "indexed": true,     "internalType": "address",     "name": "from",     "type": "address"    },    {     "indexed": true,     "internalType": "address",     "name": "to",     "type": "address"    },    {     "indexed": false,     "internalType": "uint256",     "name": "value",     "type": "uint256"    }   ],   "name": "Transfer",   "type": "event"  },  {   "inputs": [    {     "internalType": "address",     "name": "owner",     "type": "address"    },    {     "internalType": "address",     "name": "spender",     "type": "address"    }   ],   "name": "allowance",   "outputs": [    {     "internalType": "uint256",     "name": "",     "type": "uint256"    }   ],   "stateMutability": "view",   "type": "function"  },  {   "inputs": [    {     "internalType": "address",     "name": "spender",     "type": "address"    },    {     "internalType": "uint256",     "name": "amount",     "type": "uint256"    }   ],   "name": "approve",   "outputs": [    {     "internalType": "bool",     "name": "",     "type": "bool"    }   ],   "stateMutability": "nonpayable",   "type": "function"  },  {   "inputs": [    {     "internalType": "address",     "name": "account",     "type": "address"    }   ],   "name": "balanceOf",   "outputs": [    {     "internalType": "uint256",     "name": "",     "type": "uint256"    }   ],   "stateMutability": "view",   "type": "function"  },  {   "inputs": [],   "name": "decimals",   "outputs": [    {     "internalType": "uint8",     "name": "",     "type": "uint8"    }   ],   "stateMutability": "view",   "type": "function"  },  {   "inputs": [    {     "internalType": "address",     "name": "spender",     "type": "address"    },    {     "internalType": "uint256",     "name": "subtractedValue",     "type": "uint256"    }   ],   "name": "decreaseAllowance",   "outputs": [    {     "internalType": "bool",     "name": "",     "type": "bool"    }   ],   "stateMutability": "nonpayable",   "type": "function"  },  {   "inputs": [    {     "internalType": "address",     "name": "spender",     "type": "address"    },    {     "internalType": "uint256",     "name": "addedValue",     "type": "uint256"    }   ],   "name": "increaseAllowance",   "outputs": [    {     "internalType": "bool",     "name": "",     "type": "bool"    }   ],   "stateMutability": "nonpayable",   "type": "function"  },  {   "inputs": [    {     "internalType": "address",     "name": "account",     "type": "address"    },    {     "internalType": "uint256",     "name": "amount",     "type": "uint256"    }   ],   "name": "mint",   "outputs": [],   "stateMutability": "nonpayable",   "type": "function"  },  {   "inputs": [],   "name": "name",   "outputs": [    {     "internalType": "string",     "name": "",     "type": "string"    }   ],   "stateMutability": "view",   "type": "function"  },  {   "inputs": [],   "name": "symbol",   "outputs": [    {     "internalType": "string",     "name": "",     "type": "string"    }   ],   "stateMutability": "view",   "type": "function"  },  {   "inputs": [],   "name": "totalSupply",   "outputs": [    {     "internalType": "uint256",     "name": "",     "type": "uint256"    }   ],   "stateMutability": "view",   "type": "function"  },  {   "inputs": [    {     "internalType": "address",     "name": "to",     "type": "address"    },    {     "internalType": "uint256",     "name": "amount",     "type": "uint256"    }   ],   "name": "transfer",   "outputs": [    {     "internalType": "bool",     "name": "",     "type": "bool"    }   ],   "stateMutability": "nonpayable",   "type": "function"  },  {   "inputs": [    {     "internalType": "address",     "name": "from",     "type": "address"    },    {     "internalType": "address",     "name": "to",     "type": "address"    },    {     "internalType": "uint256",     "name": "amount",     "type": "uint256"    }   ],   "name": "transferFrom",   "outputs": [    {     "internalType": "bool",     "name": "",     "type": "bool"    }   ],   "stateMutability": "nonpayable",   "type": "function"  } ]',
            'utf-8'),
        EthereumAddress.fromHex('0xE497D14C1261130fCA69ce317c8905B35a907F2D'));
    ethClient.call(
        contract: contract,
        function: contract.function('balanceOf'),
        params: [fromHex.address]);
    Future<double> getBalance() async {
      final balance = await ethClient.call(
          contract: contract,
          function: contract.function('balanceOf'),
          params: [fromHex.address]);
      return balance.first.toInt() / 1000000000;
    }

    @override
    initState() {
      data = getBalance().toString();
      super.initState();
    }

    getBalance();

    return MaterialApp(
      home: Scaffold(
        body: Container(
          color: Colors.amber,
          child: Center(
              child: Text(
            data!,
            style: const TextStyle(fontSize: 40),
          )),
        ),
      ),
    );
  }
}
