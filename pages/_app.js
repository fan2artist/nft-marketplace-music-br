import '../styles/globals.css'
import Link from 'next/link'

function TheRisingClubMusicNFTMarketplace({ Component, pageProps }){
  return (
    <div>
      <nav className='border-b p-6' style={{backgroundColor: 'purple'}}>
        <p className='text-4x1 font-bold text-white'>TheRisingClub</p>
        <div className='flex mt-4 justify-center'>
          <Link href='/'>
            <a className='mr-4'>
              Main Marketplace
            </a>
          </Link>
          <Link href='/mint-item'>
            <a className='mr-6'>
              Mint Tokens
            </a>
          </Link>
          <Link href='/my-nfts'>
            <a className='mr-6'>
              My NFTs
            </a>
          </Link>
          <Link href='/account-dashboards'>
            <a className='mr-6'>
              Account Dashboards
            </a>
          </Link>
        </div>
      </nav>
      <Component {...pageProps} />
    </div>
  )
}

export default TheRisingClubMusicNFTMarketplace