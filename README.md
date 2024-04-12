# Inverse Vincenty's method

## Algorithm
Suppose that there are two points on the Earth's surface, $\overline{A}\left(\varphi_1, L_1\right)$ and $\overline{B}\left(\varphi_2, L_2\right)$, each of which is defined by certain latitude ($\varphi$) and longitude ($L$) coordinates, then the distance $D$ between these points can be determined using the inverse method of Vincenty.
	
Introduce the following notation:

$$
\begin{align}
    &a \text{ is the equatorial radius of the Earth model},\\
    &f \text{ is the flattening factor of the Earth model},\\
    &b = a\left(1 - f\right) \text{ is the polar radius of the Earth model},\\
    &\alpha_1,\,\alpha_2 \text{ — direct azimuths in points},\\
    &U_1 = \arctan{\left(\left(1 - f\right)\tan{\varphi_1}\right)},\\
    &U_2 = \arctan{\left(\left(1 - f\right)\tan{\varphi_2}\right)},\\
    &L = L_2 - L_1,\\
    &\varepsilon_\lambda = 10^{-12} \text{ — the permissible error}.
\end{align}
$$
	
Set the initial value of $\lambda\_k = L, k = 0$, and calculate the following expressions:

$$ \sin \sigma ={\sqrt {\left(\cos U\_{2}\sin \lambda\_k \right)^{2}+\left(\cos U\_{1}\sin U\_{2}-\sin U\_{1}\cos U\_{2}\cos \lambda\_k \right)^{2}}}, $$

$$ \cos \sigma =\sin U\_{1}\sin U\_{2}+\cos U\_{1}\cos U\_{2}\cos \lambda\_k, $$

$$ 	\sigma =\text {arctan2} \left(\sin \sigma ,\cos \sigma \right), $$

$$ \sin \alpha ={\frac {\cos U\_{1}\cos U\_{2}\sin \lambda\_k }{\sin \sigma }}, $$

$$ \cos \left(2\sigma \_{\text{m}}\right)=\cos \sigma -{\frac {2\sin U\_{1}\sin U\_{2}}{1-\sin ^{2}\alpha }}, $$

$$ C={\frac {1}{16}}f\cos ^{2}\alpha \left[4+f\left(4-3\cos ^{2}\alpha \right)\right], $$

$$ \lambda\_{k+1} =L+(1-C)f\sin \alpha \left\\{\sigma +C\sin \sigma \left[\cos \left(2\sigma \_{\text{m}}\right)+C\cos \sigma \left(-1+2\cos ^{2}\left(2\sigma \_{\text{m}}\right)\right)\right]\right\\} $$

The iterative calculation continues until the end condition is met:

$$ \left|\lambda\_{k+1}-\lambda\_{k}\right|\leq\varepsilon\_\lambda, $$

or until the limit on iterations is reached.

The geodetic distance and azimuths are then calculated:

$$ u^2 = \frac{a^2 - b^2}{b^2} \cos^2 \alpha, $$

$$ 	A = 1 + \frac{u^2}{16384} \left\\{ 4096 + u^2 \left[ -768 +u^2 (320 - 175u^2) \right] \right\\}, $$

$$ B = \frac{u^2}{1024} \left\\{ 256 + u^2 \left[ -128 + u^2 (74-47 u^2) \right] \right\\}, $$

$$ \Delta \sigma = B \sin \sigma \left\\{\cos(2 \sigma\_m) + \frac{1}{4}B  \left[\cos \sigma \left(-1+2 \cos^2(2 \sigma\_m)\right) - \frac{1}{6} B \cos(2 \sigma\_m)  (-3+4 \sin^2 \sigma) \left(-3+4 \cos^2 (2 \sigma\_m)\right)\right]\right\\}, $$

$$ D = b A\left(\sigma - \Delta \sigma\right), $$

$$ \alpha \_{1}=\text {arctan2} \left(\cos U\_{2}\sin \lambda\_{k+1} ,\cos U\_{1}\sin U\_{2}-\sin U\_{1}\cos U\_{2}\cos \lambda\_{k+1} \right), $$

$$ \alpha \_{2}=\text {arctan2} \left(\cos U\_{1}\sin \lambda\_{k+1} ,\cos U\_{1}\sin U\_{2}\cos \lambda\_{k+1} -\sin U\_{1}\cos U\_{2}\right). $$

## References
1. T. Vincenty. DIRECT AND INVERSE SOLUTIONS OF GEODESICS ON THE ELLIPSOID WITH APPLICATION OF NESTED EQUATIONS. Survey Review, 23(176):88–93, 4 1975. https://doi.org/10.1179/sre.1975.23.176.88
2. International Civil Aviation Organization. World Geodetic System – 1984 (WGS-84) manual, 2002. https://www.icao.int/NACC/Documents/Meetings/2014/ECARAIM/REF08-Doc9674.pdf