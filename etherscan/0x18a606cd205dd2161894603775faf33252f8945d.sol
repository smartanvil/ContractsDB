pragma solidity ^0.4.2;
/*'pragma' indique au compileur dans quelle version de Solidity ce code est &#233;crit */
contract storer {
/*'contract' indique le d&#233;but du contrat a proprement parler 'contract' est similaire
&#224; 'class' dans d'autres langages (class variables, inheritance, etc.)*/
address public owner;
string public log;
/* 29979245621189875516790
function storer() {
    owner = msg.sender ;
}
/* 'storer' est une fonction un peu particuli&#232;re, il s'agit du constructeur du contrat.
Cette fonction s'ex&#233;cute une seule fois au moment de la cr&#233;ation du contrat.
La cr&#233;ation du contrat est une transaction et comme toute transaction elle est
repr&#233;sent&#233;e en Solidity par "msg", "msg.sender" correspond  &#224; l'adresse qui
&#233;met cette transaction.  
A la cr&#233;ation du contrat la variable owner re&#231;oit l'adresse qui a d&#233;ploy&#233; le
contrat */
modifier onlyOwner {
        if (msg.sender != owner)
            throw;
        _;
    }
/* le 'modifier' permet de poser des conditions &#224; l'ex&#233;cution des fonctions.
Ici, 'onlyOwner' sera ajout&#233; &#224; la syntaxe des fonctions que l'on
veut r&#233;server au 'owner'. Le modifier teste la condion msg.sender != owner
si le requ&#234;teur de la fonction n'est pas le owner alors l'ex&#233;cution
s'interrompt, c'est le sens du 'throw'; s'il s'agit bien du owner alors
la fonction s'ex&#233;cute. Notez le '_' underscore apr&#232;s le test, il signifie
&#224; la fonction de continuer son ex&#233;cution.*/    
function store(string _log) onlyOwner() {
    log = _log;
}
/*La fonction 'store' re&#231;oit une cha&#238;ne de caract&#232;res qu'elle associe &#224; une
variable d'&#233;tat '_log'. Cette fonction n'est utilisable que par l'adresse qui
est 'owner', si c'est bien cette adresse qui fait la requ&#234;te alors la variable
'log' devient '_log'.*/
function kill() onlyOwner() {
  selfdestruct(owner); }
/* Cette derni&#232;re fonction permet de "nettoyer" la blockchain en supprimant le
contrat. Il est important de la faire figurer pour lib&#233;rer de l'espace sur
la blockchain mais aussi pour supprimer un contrat bugg&#233;. En pr&#233;cisant une
adresse selfdestruct(address), tous les ethers stock&#233;s par le contrat y sont
envoy&#233;s. Attention si une transaction envoie des ethers &#224; un contrat qui s'est
"selfdestruct" ces ethers seront perdus*/
}