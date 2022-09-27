# 參考來源 https://stackoverflow.com/questions/16908383/how-to-release-image-from-image-source-in-wpf

$bitmap = New-Object System.Windows.Media.Imaging.BitmapImage::new
$bitmap.BeginInit()
$bitmap.CacheOption = [System.Windows.Media.Imaging.BitmapCacheOption]::OnLoad
$bitmap.UriSource = New-Object System.Uri($sender.Tag[1])
$bitmap.EndInit()
$Form_imgShow.Source = $bitmap

# C#
# BitmapImage image = new BitmapImage();
# image.BeginInit();
# image.CacheOption = BitmapCacheOption.OnLoad;
# image.UriSource = new Uri(filePath);
# image.EndInit();
# imgThumbnail.Source = image;